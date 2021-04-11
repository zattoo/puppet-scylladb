# For Debian 9 only
class scylla::repo::scylla_repo (
  $key_id      = $::scylla::apt_key_id,
  $key_server  = $::scylla::apt_key_server,
  $release     = $::scylla::distro_release,
  $repos       = $::scylla::distro_repos,
  $apt_key     = $::scylla::apt_key,
  $location    = $::scylla::apt_location,
  $squid_proxy = $::scylla::squid_proxy,) {

    package { 'gnupg2':
      ensure => present,
    }

    case $::osfamily {
      'Debian': {
        #include apt
        #include apt::update
        apt::key {'scylla':
          id     => $key_id,
          server => "${key_server}",
          options => '"${squid_proxy}" --recv-keys "${apt_key}"',
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
