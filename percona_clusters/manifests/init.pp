# Class: percona_clusters
#
# This module manages percona_clusters
#
# Parameters: 
# 
# [*$node_ips *] 
# Specify $node_ips which you want include inside your mysql cluster seprated by comma this is mandatory field
# e.g 192.168.111.1,192.168.111.2,192.168.111.3
#
#[*$port*]
# Specify port on which you want to run mysql percona xtaradb cluster will use to communincate between them 
#   
#[*$wsrep_cluster_name*]
# Specify the cluster name to be assigned to this cluster 
#
#[*$wsrep_sst_method*]
# Specify the wsrep_sst_method for the clusters i.e. xtrabackup,rsync,rsync_wan,mysqldump
#
#[*$wsrep_node_address*] 
# Specify the wsrep_node_address,Please mention the node ip on which mysql percona cluster 
# is running e.g 192.168.111.1
#
#[*$wsrep_sst_auth_user*] * 
# Specify the wsrep_sst_auth_user e.g root ,This is user is user of mysql
#
#[*$wsrep_sst_auth_password*] *
# Specify the wsrep_sst_auth_password ,specify the password for mysql user 
#
#[*$query_cache_limit*]
# Specify query_cache_limit by default value is there 1M
#
#[*$max_allowed_packet*]
# Specify the max_allowed_packet default value is there 200M
#
#[*$table_open_cache*]
# Specify the table_open_cache
#
#[*$max_connections*]
# Specify the max_connections 
#
# [*$innodb_buffer_pool_size*]
# Specify the innodb_buffer_pool_size for e.g. 3000000000 = 3GB
#
#[*$innodb_flush_log_at_trx_commit*]
# Specify the innodb_flush_log_at_trx_commit.
#
#[*$innodb_lock_wait_timeout*]
# Specify the innodb_lock_wait_timeout.
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class percona_clusters 

#Define percona cluster version  here for percona 5.5 use 5.5 for percona5.6 use 5.6 
  ($percona_version = hiera('percona_clusters::$percona_version','5.6'),
  )
  {
   
  Exec { path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin',] }
  
  package { 'mysql-libs':
          ensure => 'purged',
  }
   
  package { 'percona-release-0.0-1.x86_64':
        provider => 'rpm',
        ensure   => installed,
        source   => "http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm",
        require => Package['mysql-libs'],
        }
        
        
  package { 'epel-release-6-8.noarch':
      provider => 'rpm',
      ensure   => installed,
      source   => "http://mirror-fpt-telecom.fpt.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm",
      require  => Package['percona-release-0.0-1.x86_64'],
    }
  
  exec  { "yum_ca":
     command  => 'yum -y upgrade ca-certificates --disablerepo=epel',
     require  => Package['epel-release-6-8.noarch'],
   }
    
   if ( $percona_version == '5.5' ) {
   package { 'Percona-XtraDB-Cluster-server-55.x86_64':
      ensure   => installed,
      require  => Exec["yum_ca"],
    } 
    }
    
    if ( $percona_version == '5.6' ) {
    package { 'Percona-XtraDB-Cluster-server-56.x86_64':
      ensure   => installed,
      require  => Exec["yum_ca"],
    } 
    }



}


