# == Class scylla::params
#
# This class is meant to be called from scylla
# It sets variables according to platform
#
class scylla::params {

  # ScyllaDB version
  $major_version                         = '4.4'
  $minor_version                         = '0-0'
  $release                               = '20210322.dffbcabbb-1'

  # scylla.yaml
  $cluster_name                          = 'ScyllaCluster'
  $seeds                                 = $::ipaddress
  $listen_address                        = $::ipaddress
  $broadcast_rpc_address                 = $::ipaddress
  $rpc_address                           = $::ipaddress
  $num_tokens                            = 256
  $data_file_directories                 = '/var/lib/scylla/data'
  $commitlog_directory                   = '/var/lib/scylla/commitlog'
  $commitlog_sync                        = 'periodic'
  $commitlog_sync_period_in_ms           = 10000
  $commitlog_segment_size_in_mb          = 32
  $native_transport_port                 = 9042
  $read_request_timeout_in_ms            = 5000
  $write_request_timeout_in_ms           = 2000
  $endpoint_snitch                       = 'SimpleSnitch'
  $rpc_port                              = 9160
  $api_port                              = 10000
  $api_address                           = '127.0.0.1'
  $batch_size_warn_threshold_in_kb       = 5
  $partitioner                           = 'org.apache.cassandra.dht.Murmur3Partitioner'
  $commitlog_total_space_in_mb           = '-1'
  $prometheus_port                       = 9180
  $storage_port                          = 7000
  $ssl_storage_port                      = 7001
  $auto_snapshot                         = false
  $enable_keyspace_column_family_metrics = false
  $defragment_memory_on_idle             = false

  # cassandra-rackdc.properties
  $dc                                     = 'ScyllaDC'
  $rack                                   = 'ScyllaRack'

  # Scylla_setup parameters
  $scylla_setup_skip_options              = '--no-ntp-setup --no-raid-setup'
  $scylla_setup_nic_options               = ''
  $timeout_start_seconds                  = 900

  # Scylla-JMX
  $jmx_port                               = 7199

  # node_exporter
  $node_exporter_port                     = 9100

  # Manage firewall
  $manage_firewall                        = true
  $create_firewall_zone                   = false
  $firewall_zone_name                     = 'restricted'
  $firewall_interface                     = 'bond0'
  $cpuset                                 = undef
  $scylla_args                            = '--developer-mode=1'

  # Scylla extra options
  $scylla_config_options                  = undef
  $set_up_io_benchmark                    = false
  $apt_key_id                             = '7752A0722F457FB76C0F44985E08FBD8B5D6EC9C'
  $apt_key_server                         = 'keyserver.ubuntu.com'
  $distro_release                         = $::os['distro']['codename']
  $distro_repos                           = 'non-free'
  $apt_key                                = '5e08fbd8b5d6ec9c'
  $apt_location                           = 'https://repositories.scylladb.com/scylla/downloads/scylladb/deb/scylla/deb/debian/scylladb-4.4'
  $squid_proxy                            = 'http-proxy="http://squid.zattoo.com:3128 "'

}
