# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include caddy::config
class caddy::config {
  file { '/etc/caddy':
    ensure => directory
  } -> file { '/etc/caddy/Caddyfile':
    ensure => 'present'
  }
}
