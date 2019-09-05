# == Class scylla::config
#
# This class is called from scylla
#
class scylla::config inherits ::scylla {

  exec { 'scylla_setup':
    command => "/usr/sbin/scylla_setup ${scylla::scylla_setup_skip_options} ${scylla::scylla_setup_nic_options}",
    creates => '/var/lib/scylla/.scylla_setup_done',
    before  => File['/var/lib/scylla/.scylla_setup_done'],
    timeout =>  1800,
  }

  file { '/var/lib/scylla/.scylla_setup_done':
    ensure => present,
  }

  file{ $scylla::commitlog_directory :
    ensure => directory,
    owner  => 'scylla',
    group  => 'scylla',
    mode   => '0755',
  }

  file { '/etc/scylla/scylla.yaml':
    content =>  template("${module_name}/scylla.yaml.erb")
  }

  # make scylla logs go into dedicated log as well
  file{ '/var/log/scylla' :
    ensure => directory,
    owner  => 'scylla',
    group  => 'scylla',
    mode   => '0755',
  }

  file{ '/etc/systemd/system/scylla-server.service.d' :
    ensure => directory,
    owner  => 'scylla',
    group  => 'scylla',
    mode   => '0755',
  }

  file { '/etc/systemd/system/scylla-server.service.d/10-timeout.conf':
    content =>  file('scylla/10-timeout.conf'),
  }~>
  exec { 'scylla-systemd-reload':
    command     => 'systemctl daemon-reload',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }


}
