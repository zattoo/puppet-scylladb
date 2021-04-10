# For Debian 9 only
class scylla::repo::scylla_repo (
  $key_id     = '7752A0722F457FB76C0F44985E08FBD8B5D6EC9C',
  $key_server = 'keyserver.ubuntu.com',
  $release    = $::os['distro']['codename'],
  $repos      = 'non-free',
  $apt_key    = '5e08fbd8b5d6ec9c',
  $location   = 'https://repositories.scylladb.com/scylla/downloads/scylladb/deb/scylla/deb/debian/scylladb-4.4',) {

    package { 'gnupg2':
      ensure => present,
    }

    case $::osfamily {
      'Debian': {
        #include apt
        #include apt::update
        apt::key {'scylla':
          id     => $key_id,
          server => 'keyserver.ubuntu.com',
          options => 'http-proxy="http://squid.zattoo.com:3128 " --recv-keys "${apt_key}"',
        }

        apt::source { 'scylla.source.https.list':
          location => "${location}",
          release  => "${release}",
          repos    => "${repos}",
          notify   => Exec['apt_update'],
        }

      }
      default: {
        warning("OS family ${::osfamily} not supported")
      }
    }
  }
