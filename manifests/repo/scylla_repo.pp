class scylla::repo::scylla_repo (
  $key_id  = '0C7BD5EFB64F8D4F9ACF4D3284ACD5B2D02945ED',
  $key_server = 'keyserver.ubuntu.com',
  $release = 'jessie',
  $repos = 'non-free'
  $location = 'https://repositories.scylladb.com/scylla/downloads/scylladb/b956f642-36ba-4ba7-a565-68df8f10acb5/scylla/deb/debian/scylladb-3.0',
  ) {

    package { 'apt-transport-https':
      ensure => present
    }
    package { 'gnupg-curl':
      ensure => present
    }
  
    case $::osfamily {
      'Debian': {
        include apt
        include apt::update
        include apt::source

        apt::source {'scylla.sources':
          location => $location,
          repos  => $repos,
          release  => $release,
          key:
            id: $key_id,
            server: $key_server,
          notify => Exec['apt_update'],
        }
        package { 'jessie-backports':
          ensure => present
        }
        package { 'ca-certificates-java':
          ensure => present
        }
        package { 'openjdk-8-jre-headless':
          ensure => present
        }
        package { 'gnupg-curl':
          ensure => present
        }
      'Ubuntu': {
        include apt
        include apt::update
        include apt::source

        apt::source {'scylla.sources':
          location => $location,
          repos  => $repos,
          release  => $release,
          key:
            id: $key_id,
            server: $key_server,
          notify => Exec['apt_update'],
        }
       package { 'jessie-backports':
          ensure => present
        }
        package { 'ca-certificates-java':
          ensure => present
        }
        package { 'openjdk-8-jre-headless':
          ensure => present
        }
        package { 'gnupg-curl':
          ensure => present
        }
      default: {
        warning("OS family ${::osfamily} not supported")
      }
    }
}