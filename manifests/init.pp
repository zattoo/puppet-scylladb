# == Class scylla
#
# Base Scylla class
#

class scylla (
  $major_version                        = $scylla::params::major_version,
  $minor_version                        = $scylla::params::minor_version,
  $release                              = $scylla::params::release,
  $cluster_name                         = $scylla::params::cluster_name,
  $seeds                                = $scylla::params::seeds,
  $listen_address                       = $scylla::params::listen_address,
  $broadcast_rpc_address                = $scylla::params::broadcast_rpc_address,
  $rpc_address                          = $scylla::params::rpc_address,
  $num_tokens                           = $scylla::params::num_tokens,
  $data_file_directories                = $scylla::params::data_file_directories,
  $enable_keyspace_column_family_metrics = $scylla::params::enable_keyspace_column_family_metrics,
  $commitlog_directory                  = $scylla::params::commitlog_directory,
  $commitlog_sync                       = $scylla::params::commitlog_sync,
  $commitlog_sync_period_in_ms          = $scylla::params::commitlog_sync_period_in_ms,
  $commitlog_segment_size_in_mb         = $scylla::params::commitlog_segment_size_in_mb,
  $native_transport_port                = $scylla::params::native_transport_port,
  $read_request_timeout_in_ms           = $scylla::params::read_request_timeout_in_ms,
  $write_request_timeout_in_ms          = $scylla::params::write_request_timeout_in_ms,
  $endpoint_snitch                      = $scylla::params::endpoint_snitch,
  $rpc_port                             = $scylla::params::rpc_port,
  $api_port                             = $scylla::params::api_port,
  $api_address                          = $scylla::params::api_address,
  $batch_size_warn_threshold_in_kb      = $scylla::params::batch_size_warn_threshold_in_kb,
  $partitioner                          = $scylla::params::partitioner,
  $commitlog_total_space_in_mb          = $scylla::params::commitlog_total_space_in_mb,
  $prometheus_port                      = $scylla::params::prometheus_port,
  $storage_port                         = $scylla::params::storage_port,
  $ssl_storage_port                     = $scylla::params::ssl_storage_port,
  $dc                                   = $scylla::params::dc,
  $rack                                 = $scylla::params::rack,
  $scylla_setup_skip_options            = $scylla::params::scylla_setup_skip_options,
  $scylla_setup_nic_options             = $scylla::params::scylla_setup_nic_options,
  $timeout_start_seconds                = $scylla::params::timeout_start_seconds,
  $jmx_port                             = $scylla::params::jmx_port,
  $node_exporter_port                   = $scylla::params::node_exporter_port,
  $manage_firewall                      = $scylla::params::manage_firewall,
  $create_firewall_zone                 = $scylla::params::create_firewall_zone,
  $firewall_zone_name                   = $scylla::params::firewall_zone_name,
  $firewall_interface                   = $scylla::params::firewall_interface,
  $auto_snapshot                        = $scylla::params::auto_snapshot,
  $defragment_memory_on_idle            = $scylla::params::defragment_memory_on_idle,
  $cpuset                               = $scylla::params::cpuset,
  $scylla_args                          = $scylla::params::scylla_args,
  $scylla_config_options                = $scylla::params::scylla_config_options,
  $set_up_io_benchmark                  = $scylla::params::set_up_io_benchmark,
  $apt_key_id                           = $scylla::params::apt_key_id,
  $apt_key_server                       = $scylla::params::apt_key_server,
  $distro_release                       = $scylla::params::distro_release,
  $distro_repos                         = $scylla::params::distro_repos,
  $apt_key                              = $scylla::params::apt_key,
  $apt_location                         = $scylla::params::apt_location,
  $squid_proxy                          = $scylla::params::squid_proxy,

  ) inherits scylla::params {

    anchor  { 'scylla::begin': }
    ->  class   { '::scylla::repo::scylla_repo': }
    ->  class   { '::scylla::packages': }
    ->  class   { '::scylla::config': }
    ->  class   { '::scylla::firewalld': }
    ->  anchor  { 'scylla::end': }

}
