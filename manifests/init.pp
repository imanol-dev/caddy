# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include caddy
class caddy (
  String $package_ensure = 'present',
  String $service_ensure = 'running',
  Boolean $service_enable = true,
  Optional[Hash] $exposed_addresses_content = {},
  Optional[Hash] $reversed_addresses_content = {}
) {

  contain caddy::install
  contain caddy::config
  contain caddy::service

  if $caddy::package_ensure == 'absent' {
    Class['::caddy::service']
    -> Class['::caddy::install']
    -> Class['::caddy::config']
  } else {
    Class['::caddy::install']
    -> Class['::caddy::config']
    ~> Class['::caddy::service']
  }
}
