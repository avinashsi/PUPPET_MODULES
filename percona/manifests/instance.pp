define percona::instance 
(
    $backup_dir,
    $mysql_user,
    $mysql_passwd
)

{
  Exec {
    path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'], }
              
  package { 'percona-release-0.1-3':
    provider => 'rpm',
    ensure   => installed,
    source   => "https://www.percona.com/redir/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm";
    }
      
  package { 'percona-xtrabackup.x86_64':
    ensure  => installed,
    require => Package["percona-release-0.1-3"];
    }
    
  file {"$backup_dir":
    ensure  => directory,
    owner   => root, 
    group   => root,            
    } 
          
 exec { "mysql_backup":
    command => "innobackupex  --user=${mysql_user} --password=${mysql_passwd} $backup_dir",
    require => Exec["backup_mysql"];
    }

  exec { "prep_backup":
    command => "innobackupex --apply-log $backup_dir",
    require => Exec["mysql_backup"];
    }

  }

