# For Debian 9 only
class scylla::repo::scylla_repo (
  $key_id  = '0C7BD5EFB64F8D4F9ACF4D3284ACD5B2D02945ED',
  $key_url = 'https://download.opensuse.org/repositories/home:/scylladb:/scylla-3rdparty-stretch/Debian_9.0/Release.key',
  $key_server = 'keyserver.ubuntu.com',
  $release = 'stretch',
  $repos = 'non-free',
  $location = 'https://repositories.scylladb.com/scylla/downloads/scylladb/b956f642-36ba-4ba7-a565-68df8f10acb5/scylla/deb/debian/scylladb-3.0',) {

    package { 'gnupg2':
      ensure => present,
    }

    case $::osfamily {
      'Debian': {
        #include apt
        #include apt::update
        apt::key {'scylla':
          id     => $key_id,
          source => $key_url,
          server => 'keyserver.ubuntu.com',
          options => 'http-proxy="http://squid.zattoo.com:3128 " --recv-keys 17723034C56D4B19',

        }

        apt::source { 'scylla.source.https.list':
          location => "https://repositories.scylladb.com/scylla/downloads/scylladb/b956f642-36ba-4ba7-a565-68df8f10acb5/scylla/deb/debian/scylladb-3.0",
          release  => $::os['distro']['codename'],
          repos    => 'non-free',
          notify   => Exec['apt_update'],
        }
        apt::source { 'scylla.source.http.list':
          location => "http://download.opensuse.org/repositories/home:/scylladb:/scylla-3rdparty-stretch/Debian_9.0/",
          release  => './',
          repos    => '',
          notify   => Exec['apt_update'],

        }
      }
      default: {
        warning("OS family ${::osfamily} not supported")
      }
    }
  }
