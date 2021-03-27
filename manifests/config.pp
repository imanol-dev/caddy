# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include caddy::config
class caddy::config {

  $_config_directory_ensure = $caddy::package_ensure ? {
    'present' => 'directory',
    'absent'  => 'absent'
  }

  file { '/etc/caddy':
    ensure => $_config_directory_ensure
  } -> file { '/etc/caddy/Caddyfile':
    ensure => $caddy::package_ensure
  }
}
