# Class: nginx_legacy::service
#
# This module manages NGINX service management and vhost rebuild
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class nginx_legacy::service(
  $configtest_enable = $::nginx_legacy::configtest_enable,
  $service_restart   = $::nginx_legacy::service_restart,
  $service_ensure    = $::nginx_legacy::service_ensure,
  $service_name      = 'nginx',
  $service_flags     = undef,
) {

  $service_enable = $service_ensure ? {
    running => true,
    absent => false,
    stopped => false,
    'undef' => undef,
    default => true,
  }

  if $service_ensure == 'undef' {
    $service_ensure_real = undef
  } else {
    $service_ensure_real = $service_ensure
  }

  case $::osfamily {
    'OpenBSD': {
      service { 'nginx':
        ensure     => $service_ensure_real,
        name       => $service_name,
        enable     => $service_enable,
        flags      => $service_flags,
        hasstatus  => true,
        hasrestart => true,
      }
    }
    default: {
      service { 'nginx':
        ensure     => $service_ensure_real,
        name       => $service_name,
        enable     => $service_enable,
        hasstatus  => true,
        hasrestart => true,
      }
    }
  }

  if $configtest_enable == true {
    Service['nginx'] {
      restart => $service_restart,
    }
  }
}
