# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include caddy
class caddy (
  String $package_ensure
) {

  contain caddy::install
  contain caddy::config

  Class['::caddy::install']
  -> Class['::caddy::config']
}
