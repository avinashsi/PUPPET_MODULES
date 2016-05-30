# == Class: epel::params

#
class epel::params {
  case $::osfamily {
    'redhat' : {
      case $::operatingsystemrelease {
       /^6.*$/ : {
          $rpmprovider = 'rpm'
          $sourcerpm = 'http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'
        }
        /^7.*$/ : {
          $rpmprovider = 'yum'
          $sourcerpm = undef
        }
         /^5.*$/ : {
          $rpmprovider = 'rpm'
          $sourcerpm = 'http://mirror.uv.es/mirror/fedora-epel/5/x86_64/epel-release-5-4.noarch.rpm'
        }
        default : {
          fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")
        }
      }

    }
    default  : {
      fail('Unsupported OS!')
    }
  }
}