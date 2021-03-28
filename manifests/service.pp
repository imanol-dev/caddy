# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include caddy::service
class caddy::service {

  if $caddy::package_ensure == 'absent' {
    $_ensure_service = 'stopped'
    $_enable_service = false
  } else {
    $_ensure_service = $caddy::ensure_service
    $_enable_service = $caddy::enable_service
  }

  service { 'caddy':
    ensure => $_ensure_service,
    enable => $_enable_service
  }
}
