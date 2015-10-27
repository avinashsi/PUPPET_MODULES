# percona_clusters #

This is the percona_clusters module. It provides...
                                                                       
![Architecture](https://github.com/avinashsi/images/blob/master/logo_percona_xtradbcluster_new.png)


####Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with percona_cluster](#setup)
    * [What percona_cluster affects](#what-jboss-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with jboss](#beginning-with-jboss)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

##Overview

The percona_clusters module handles installing, configuring, and running Percona XtraDb MySql Cluster (5.5 and 5.6)
across a the nodes .

	
##Setup

###What percona_clusters affects

* Installs and configure Percona XtraDB Cluster for  MySql.
* Configures ip's of the nodee in my.cnf file according to user requirement for clusters
* Configure wsrep_sst_method in my.cnf according to user requirement 


###Beginning with percona_clusters

You haves to pass in parameters from nodes.pp file in order to run this module. Below is the e.g. showing for the bootstrap node

```puppet

node "node1.com"
{

 include percona_clusters
    percona_clusters::instance {'node1':
        node_ips => '192.168.111.11:4567,192.168.111.12:4567,192.168.111.13:4567',
        wsrep_node_address => '192.168.111.11',
        wsrep_sst_auth_user => 'root',
        wsrep_sst_auth_password =>'paxcel123',
        wsrep_cluster_name => 'paxcel',
        wsrep_sst_method =>'xtrabackup',
        table_open_cache =>'100',
        max_connections =>'15',
        innodb_buffer_pool_size =>'512',
        innodb_lock_wait_timeout =>'15',
       }

    exec {'boot_strap_cluster':
        path => ['/usr/bin', '/usr/sbin', '/bin', '/sbin',],
        command => "/etc/init.d/mysql bootstrap-pxc",
        subscribe   => File["/etc/my.cnf"],
        refreshonly => true,
        require => Class['percona_clusters'],
        }

  exec { 'create-root-password' :
        path => ['/usr/bin', '/usr/sbin', '/bin', '/sbin',],
        onlyif  => "mysqladmin -u root status",
        command => "mysqladmin -u root password paxcel123",
        require => Exec['boot_strap_cluster'],
        }

}

```

For agent nodes 

```puppet

node "node2.com"
{
 include percona_clusters
    percona_clusters::instance {'node2':
        node_ips => '192.168.111.11:4567,192.168.111.12:4567,192.168.111.13:4567',
        wsrep_node_address => '192.168.111.12',
        wsrep_sst_auth_user => 'root',
        wsrep_sst_auth_password =>'paxcel123',
        wsrep_cluster_name => 'paxcel',
        wsrep_sst_method =>'xtrabackup',
        table_open_cache =>'100',
        max_connections =>'15',
        innodb_buffer_pool_size =>'512',
        innodb_lock_wait_timeout =>'15',
       }

    exec {'start_node2':
        path => ['/usr/bin', '/usr/sbin', '/bin', '/sbin',],
        command => "/etc/init.d/mysql start",
        subscribe   => File["/etc/my.cnf"],
        refreshonly => true,
        require => Class['percona_clusters'],
        }

}

```

###Parameters

The following parameters are available in the percona_clusters module which are needed to be defined in nodes.pp file

####`node_ips`

Specify $node_ips which you want include inside your mysql cluster seprated by comma this is mandatory field
e.g 192.168.111.11:4567,192.168.111.12:4567,192.168.111.13:4567
####`port`

Specify port on which you want to run mysql percona xtaradb cluster will use to communincate between them

####`wsrep_cluster_name`

Specify the cluster name to be assigned to this cluster.

####`wsrep_sst_method`

Specify the wsrep_sst_method for the clusters i.e. xtrabackup,rsync,rsync_wan,mysqldump.

####`wsrep_node_address`

Specify the wsrep_node_address,Please mention the node ip on which mysql percona cluster is running e.g 192.168.111.1

####`wsrep_sst_auth_user`

Specify the wsrep_sst_auth_user e.g root ,This is user is user of mysql

####`wsrep_sst_auth_password`

Specify the wsrep_sst_auth_password ,specify the password for mysql user

####`table_open_cache`

Specify the table_open_cache

####`max_connections`

Specify the max_connections
 
####`innodb_buffer_pool_size`

Specify the innodb_buffer_pool_size for e.g. 3000000000 = 3GB
 
####`innodb_flush_log_at_trx_commit`

Specify the innodb_flush_log_at_trx_commit
 
####`innodb_lock_wait_timeout`

Specify the innodb_lock_wait_timeout
 

The following parameter are present inside the instance.pp file present inside manifests folder of the module
instance.pp

####`query_cache_limit`

Specify query_cache_limit by default value is there 1M.

####`max_allowed_packet`

Specify the max_allowed_packet default value is there 200M

####`innodb_flush_log_at_trx_commit`

Specify the innodb_flush_log_at_trx_commit



##Limitations

This module has been built on and tested against Puppet 2.7 and higher.

The module has been tested on:

* RedHat Enterprise Linux 5/6
* CentOS 5/6

All trademarks and registered trademarks are the property of their respective owners.
