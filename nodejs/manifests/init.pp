# Class: nodejs
#
# This module manages nodejs
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class nodejs 
(
$node_dir='/usr/node',
$node_home,
$env_path='/etc/profile.d/node.sh',
)
{
Exec {
      path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'], }
      
      
file {"$node_dir":
      ensure  => directory,
      owner   => root, 
      group   => root,            
    }  

 exec { 'get_node_installer':
      cwd => $node_dir,
      command => 'wget https://raw.githubusercontent.com/avinashsi/files/master/node-v0.12.2-linux-x64.tar.gz',
      unless  => "test -e node-v0.12.2-linux-x64.tar.gz ",
      require => File["${node_dir}"],
    }
 
 exec { 'untar_node_installer':
      cwd => $node_dir,
      command => 'tar -zxvf node-v0.12.2-linux-x64.tar.gz ',
      unless  => "test -e node-v0.12.2-linux-x64",
      creates => $node_home,
      refreshonly => true,
      require => File["${node_dir}"],
    }
 
    exec { "set_node_home":
      command => "echo 'export NODE_HOME=${node_home}'>> ${env_path}",
      unless => "grep 'JAVA_HOME=${node_home}' ${env_path}",
      require => Exec["untar_node_installer"],
    }
  
    exec { "node_path":
      command => "echo 'export PATH=\$NODE_HOME/bin:\$PATH' >> ${env_path}",
      unless => "grep 'export PATH=\$NODE_HOME/bin:\$PATH' ${env_path}",
      require => Exec["set_java_home"],
    }
    
    exec { "set_env":
      command => "bash -c 'source ${env_path}'",
      require => Exec["node_path"];
    }
 
}
