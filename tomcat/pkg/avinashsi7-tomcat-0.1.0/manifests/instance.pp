define tomcat::instance 
(
$tomcat_version,
$tomcat_dir='/usr/tomcat',
$connector_port,
$redirectPort,
$server_port,
$connector_ajp_port,

)

{
    include tomcat
  
    case $::osfamily {
      Debian  :{ $supported = true }
      RedHat  :{ $supported = true }
      Centos  :{ $supported = true }
      default :{ fail("The ${module_name} module is not supported on ${::osfamily} based systems") }
    }
  
     
    if ($tomcat_version == undef) {
      fail('tomcat_version parameter must be set')
    }


    if !(('7' in $tomcat_version) or ('8' in $tomcat_version)) {
      fail('tomcat_version must be either 7 or 8')
    }
    
    if ($connector_port == undef) {
      $connector_port='8080'
    }
    
    if ($redirectPort == undef) {
      $redirectPort='8443'
    }
    
    if ($server_port == undef) {
      $server_port='8005'
    }

    if ($connector_ajp_port == undef) {
      $connector_ajp_port='8009'
    }
    
    Exec {
      path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'], }
    
    file {"$tomcat_dir":
      ensure  => directory,
      owner   => root, 
      group   => root,            
    }  
  
   case $tomcat_version {
    '8': {
      $tomcatDownloadURI 	= "https://github.com/avinashsi/images/raw/master/apache-tomcat-8.0.28.tar.gz"
      $web_home 	        = "${tomcat_dir}/apache-tomcat-8.0.28"
      $tomcat_file_name	= "apache-tomcat-8.0.28"
    }
    '7': {
      $tomcatDownloadURI 	= "https://github.com/avinashsi/images/raw/master/apache-tomcat-7.0.65.tar.gz"
      $web_home 		= "${tomcat_dir}/apache-tomcat-7.0.65"
      $tomcat_file_name	= "apache-tomcat-7.0.65"
    }
    default: {
      fail("Unsupported tomcat_version: ${tomcat_version}.  Implement me?")
    }
  }	
		
		
  if ( $tomcat_version in [ '7', '8' ] ) {	
   exec { 'get_tomcat':
     cwd     => $tomcat_dir,
     command => "wget ${tomcatDownloadURI}",
     unless  => "test -e ${tomcat_file_name}.tar.gz",
     timeout => 1200,
     require => File["$tomcat_dir"],
    }	
  }
		
  if ( $tomcat_version in [ '7', '8' ] ) {
   exec { 'extract_tomcat':
    cwd => "${tomcat_dir}",
    command => "tar xzf ${tomcat_file_name}.tar.gz",
    unless  => "test -e ${tomcat_file_name}",
    require => Exec['get_tomcat'],
   }
  }   

 
  if ( $tomcat_version in [ '7' ] ) {
  file { "$tomcat_dir/$tomcat_file_name/conf/server.xml":
    mode    => '600',
    owner   => root,
    group   => root,
    backup  => false,
    content => template('tomcat/server7.xml.erb'),
    require => Exec['extract_tomcat'],
    }
  }
  if ( $tomcat_version in [ '8' ] ) {
  file { "$tomcat_dir/$tomcat_file_name/conf/server.xml":
    mode    => '600',
    owner   => root,
    group   => root,
    backup  => false,
    content => template('tomcat/server8.xml.erb'),
    require => Exec['extract_tomcat'],
    }
 }
  
   
  if ( $tomcat_version in [ '7', '8' ] ) {
  file { "/etc/init.d/tomcat":
     mode    => '777',
     owner   => root,
     group   => root,
     content => template('tomcat/tomcat.erb'),
     backup  => false,
     require => File["${tomcat_dir}/$tomcat_file_name/conf/server.xml"],
    } 
  }
  
  
}
  
  
