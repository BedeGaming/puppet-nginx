include nginx

nginx_legacy::resource::upstream { 'proxypass':
  ensure  => present,
  members => [
        'localhost:3000',
        'localhost:3001',
        'localhost:3002',
  ],
}
