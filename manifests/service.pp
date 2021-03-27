# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include caddy::service
class caddy::service {
  service { 'caddy':
    ensure => $caddy::ensure_service,
    enable => $caddy::enable_service
  }
}
