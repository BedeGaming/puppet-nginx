# Class: nginx-legacy::package
#
# This module manages NGINX package installation
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
class nginx-legacy::package(
  $package_name   = $::nginx-legacy::params::package_name,
  $package_source = 'nginx',
  $package_ensure = 'present',
  $package_flavor = undef,
  $manage_repo    = $::nginx-legacy::params::manage_repo,
) inherits ::nginx-legacy::params {

  anchor { 'nginx-legacy::package::begin': }
  anchor { 'nginx-legacy::package::end': }

  case $::osfamily {
    'redhat': {
      class { '::nginx-legacy::package::redhat':
        manage_repo    => $manage_repo,
        package_source => $package_source,
        package_ensure => $package_ensure,
        package_name   => $package_name,
        require        => Anchor['nginx-legacy::package::begin'],
        before         => Anchor['nginx-legacy::package::end'],
      }
    }
    'debian': {
      class { '::nginx-legacy::package::debian':
        package_name   => $package_name,
        package_source => $package_source,
        package_ensure => $package_ensure,
        manage_repo    => $manage_repo,
        require        => Anchor['nginx-legacy::package::begin'],
        before         => Anchor['nginx-legacy::package::end'],
      }
    }
    'Solaris': {
      # $package_name needs to be specified. SFEnginx,CSWnginx depending on
      # where you get it.
      if $package_name == undef {
        fail('You must supply a value for $package_name on Solaris')
      }

      package { 'nginx':
        ensure => $package_ensure,
        name   => $package_name,
        source => $package_source,
      }
    }
    'OpenBSD': {
      package { $package_name:
        ensure => $package_ensure,
        flavor => $package_flavor,
      }
    }
    default: {
      package { $package_name:
        ensure => $package_ensure,
      }
    }
  }
}
