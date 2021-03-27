# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include caddy::install
class caddy::install {
  $_caddy_url = 'https://caddyserver.com/api/download?os=linux&arch=amd64&idempotency=2337053798249'

  if $caddy::package_ensure == 'present' {
    exec { 'caddy download':
      command => "wget ${_caddy_url} -O /usr/bin/caddy",
      path    => '/usr/bin:/usr/sbin:/bin',
      unless  => 'test -f /usr/bin/caddy'
    }
    -> exec { 'caddy bin rights':
      command => 'chmod +x /usr/bin/caddy',
      path    => '/usr/bin:/usr/sbin:/bin'
    }
  } elsif $caddy::package_ensure == 'absent' {
    file { '/usr/bin/caddy':
      ensure => $caddy::package_ensure
    }
  }
}
