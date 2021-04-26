# == Class scylla::config
#
# This class is called from scylla
#
class scylla::config inherits ::scylla {

  exec { 'scylla_setup':
    command => "/usr/sbin/scylla_setup ${scylla::scylla_setup_skip_options}",
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

  file { '/etc/scylla.d/cpuset.conf':
    content =>  template("${module_name}/cpuset.erb")
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

  exec { 'scylla-systemd-reload':
    command     => 'systemctl daemon-reload',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }

  if $scylla::set_up_io_benchmark == true {
    exec { 'scylla_io_setup':
      command => "/usr/lib/scylla/scylla_io_setup",
      creates => '/var/lib/scylla/.scylla_io_setup_done',
      before  => File['/var/lib/scylla/.scylla_io_setup_done'],
      timeout =>  1800,
    }

    file { '/var/lib/scylla/.scylla_io_setup_done':
      ensure => present,
    }
  }

  file_line { 'execstart_scylla':
    ensure => present,
    path   => '/lib/systemd/system/scylla-server.service',
    line   => "ExecStart=/usr/bin/scylla ${scylla_args}",
    match  => "^ExecStart=.*",
    notify => Exec['scylla-systemd-reload'],
  }

  file_line { 'timeoutStart_scylla':
    ensure => present,
    path   => '/lib/systemd/system/scylla-server.service',
    line   => "TimeoutStartSec=${timeout_start_seconds}",
    match  => "^TimeoutStartSec=.*",
    notify => Exec['scylla-systemd-reload'],
  }

  service { 'scylla-server':
    ensure => 'running',
    enable => 'true',
  }


}
