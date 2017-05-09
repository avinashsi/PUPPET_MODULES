# Class: jenkins
#
# This module manages jenkins
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class jenkins {
  
  Exec {path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'], }
  
    case $::osfamily {
      RedHat  :{ $supported = true }
      Centos  :{ $supported = true }
      default :{ fail("The ${module_name} module is not supported on ${::osfamily} based systems") }
    }
    
    user {'jenkins':
      ensure     => 'present',
      #groups     => $::jenkins_node::groups,
      home       => '/var/lib/jenkins',
      managehome => true,
    }
    
    exec { 'get_jenkins_repo':
      cwd   => '/etc/yum.repos.d/',
      command => "wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo",
      unless  => "test -e jenkins.repo",
      timeout => 1200,
    } 

   package { 'jenkins':
     ensure  => installed,
     require => Exec["get_jenkins_repo"];
    }

  service { "jenkins":
          enable => true,
              ensure => running,
              require => Package["jenkins"];
          }


}
