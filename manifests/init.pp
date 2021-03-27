# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include caddy
class caddy (
  String $package_ensure,
  Hash[String, Hash[Array[String], String]] $exposed_addresses_content,
) {

  contain caddy::install
  contain caddy::config

  Class['::caddy::install']
  -> Class['::caddy::config']
}


/*

caddy::exposed_addresses_content:
  server1:
    addresess:
      - '192.168.13.39:443'
    content: 'Hello, world!'
  server2:
    addresses:
      - '192.168.13.39:8443'
      - '192.168.13.39:8543'
      - 'localhost'
    content: 'Alternative Hello!!'



192.168.13.39:443 {
  respond "Hello, world!"
}

192.168.13.39:8443, 192.168.13.39:8543, localhost {
  respond "Alternative Hello!!"
}

192.168.13.39:8081, 192.168.13.39:8082 {
  reverse_proxy https://192.168.13.39:8443
}
*/
