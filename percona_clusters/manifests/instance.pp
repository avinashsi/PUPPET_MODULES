# Class: percona_clusters::instance
#
# This class defines default parameters used by the main module class percona_clusters
# 
#
# == Variables
#
# Refer to percona_clusters class for the variables defined here.


define percona_clusters::instance 
(
$node_ips,
$data_dir='/var/lib/mysql',
$port,
$wsrep_cluster_name,
$wsrep_sst_method,
$wsrep_node_address,
$wsrep_provider='/usr/lib64/libgalera_smm.so',
$wsrep_sst_auth_user,
$wsrep_sst_auth_password,
$query_cache_limit='1M',
$max_allowed_packet='200M',
$table_open_cache,
$max_connections,
$innodb_buffer_pool_size,
$innodb_flush_log_at_trx_commit='2',
$innodb_lock_wait_timeout,
)

{
  include percona_clusters

  if ! $node_ips {
     fail ('You must specify the node_ips parameter')
  }
 

  if ! $wsrep_node_address 
  { 
    fail ('You must specify the wsrep_node_address parameter in percona or percona::params')
  }


  if ! $wsrep_sst_auth_user 
  { 
    fail ('You must specify the wsrep_sst_auth_user parameter in percona or percona::params')
  } 

  if ! $wsrep_sst_auth_password 
  { 
    fail ('You must specify the wsrep_sst_auth_password  parameter in percona or percona::params')
  } 


  file {"/etc/my.cnf":
    mode    => '600',
    owner   => root,
    group   => root,
    backup  => false,
    content => template('percona_clusters/my.cnf.erb'),
   }


}
