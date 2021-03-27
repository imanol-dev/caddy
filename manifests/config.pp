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
    ensure  => $caddy::package_ensure,
    group   => 'caddy',
    owner   => 'caddy',
    content => epp('caddy/Caddyfile.epp', {
      'exposed_addresses_content'  => $caddy::exposed_addresses_content,
      'reversed_addresses_content' => $caddy::reversed_addresses_content,
    }),
  }

  file { '/etc/systemd/system/caddy.service':
    ensure => $caddy::package_ensure,
    source => 'puppet:///modules/caddy/caddy.service',
    owner  => 0,
    group  => 0
  }
}
