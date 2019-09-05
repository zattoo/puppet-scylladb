# For Debian 9 only
class scylla::repo::scylla_repo (
  $key_id  = '0C7BD5EFB64F8D4F9ACF4D3284ACD5B2D02945ED',
  $key_url = 'https://download.opensuse.org/repositories/home:/scylladb:/scylla-3rdparty-stretch/Debian_9.0/Release.key',
  $key_server = 'keyserver.ubuntu.com',
  $release = 'stretch',
  $repos = 'non-free',
  $location = 'https://repositories.scylladb.com/scylla/downloads/scylladb/b956f642-36ba-4ba7-a565-68df8f10acb5/scylla/deb/debian/scylladb-3.0',) {


    $required_packages = ['apt-transport-https','wget','gnupg2', 'dirmngr']

    package { $required_packages:
    ensure => present,
    require  => Exec['apt_update'],
    }

    case $::osfamily {
      'Debian': {
        include apt
        include apt::update
        apt::key {'scylla':
         id     => $key_id,
         source => $key_url,
        }
        exec { "recieve gpg key":
          path      => '/bin:/usr/bin:/sbin:/usr/sbin',
          command   => "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 17723034C56D4B19",
        }
        exec { "scylla.source.list":
          path      => '/bin:/usr/bin:/sbin:/usr/sbin',
          command   => "wget -O /etc/apt/sources.list.d/scylla.list http://repositories.scylladb.com/scylla/repo/b956f642-36ba-4ba7-a565-68df8f10acb5/debian/scylladb-3.0-stretch.list",
        }
        package { 'scylla':
          ensure => present,
          require  => Exec['apt_update'],
        }
      }
      default: {
        warning("OS family ${::osfamily} not supported")
      }
    }
  }
