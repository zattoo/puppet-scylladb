# == Class scylla::config
#
# Installs the Scylla packages
#
class scylla::packages {

  package { 'scylla':
    ensure => "${scylla::major_version}.${scylla::minor_version}.${scylla::release}",
  }

}