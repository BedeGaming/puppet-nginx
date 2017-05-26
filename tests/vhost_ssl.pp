include nginx

nginx_legacy::resource::vhost { 'test3.local test3':
  ensure          => present,
  www_root        => '/var/www/nginx-default',
  ssl             => true,
  ssl_cert        => 'puppet:///modules/sslkey/whildcard_mydomain.crt',
  ssl_client_cert => 'puppet:///modules/sslkey/whildcard_mydomain.crt',
  ssl_key         => 'puppet:///modules/sslkey/whildcard_mydomain.key'
}

nginx_legacy::resource::vhost { 'test2.local test2':
  ensure   => present,
  www_root => '/var/www/nginx-default',
  ssl      => true,
  ssl_cert => 'puppet:///modules/sslkey/whildcard_mydomain.crt',
  ssl_key  => 'puppet:///modules/sslkey/whildcard_mydomain.key'
}

nginx_legacy::resource::location { 'test2.local-bob':
  ensure   => present,
  www_root => '/var/www/bob',
  location => '/bob',
  vhost    => 'test2.local test2',
}

nginx_legacy::resource::location { 'test3.local-bob':
  ensure   => present,
  www_root => '/var/www/bob',
  location => '/bob',
  vhost    => 'test3.local test3',
}


