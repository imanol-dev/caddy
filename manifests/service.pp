# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include caddy::service
class caddy::service {

  if $caddy::package_ensure == 'absent' {
    $ensure_service_param = 'stopped'
    $enable_service_param = false
  } else {
    $ensure_service_param = $caddy::service_ensure
    $enable_service_param = $caddy::service_enable
  }

  service { 'caddy':
    ensure => $ensure_service_param,
    enable => $enable_service_param
  }
}
