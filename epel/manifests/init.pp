# == Class: epel
#
#
class epel ($ensure='installed') inherits epel::params {

package { 'epel*':
    ensure  => 'purged',
      
    }

  exec { 'update-ca':
    command => '/usr/bin/yum upgrade ca-certificates --disablerepo=epel* -y > /var/log/yum.ca-certificates.log',
    creates => '/var/log/yum.ca-certificates.log',
  }

  package { 'epel-release':
    ensure   => $ensure,
    provider => $epel::params::rpmprovider,
    source   => $epel::params::sourcerpm,
    require  => Exec['update-ca'],
  }
}