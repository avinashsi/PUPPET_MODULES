define java::instance 
(
$java_version,
$java_dir='/usr/java',
$env_path='/etc/profile.d/java.sh',
)

{
    include java
  
    case $::osfamily {
      Debian  :{ $supported = true }
      RedHat  :{ $supported = true }
      Centos  :{ $supported = true }
      default :{ fail("The ${module_name} module is not supported on ${::osfamily} based systems") }
    }
  
    case $::platform {
      'x64': {
      $plat_filename = 'x64'
      }
      'x86': {
      $plat_filename = 'i586'
      }
    default: {
    #fail("Unsupported platform: ${::platform}. Implement me?")
      $plat_filename = 'x64'
      }
    }
    
    if ($java_version == undef) {
      fail('java_version parameter must be set')
    }


    if !(('7' in $java_version) or ('8' in $java_version)) {
      fail('java_version must be either 7 or 8')
    }


    Exec {
      path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'], }
    
    file {"$java_dir":
      ensure  => directory,
      owner   => root, 
      group   => root,            
    }  
  
    case $java_version {
    '8':{
      $javaDownloadURI = "http://download.oracle.com/otn-pub/java/jdk/8-b132/jdk-8-linux-${plat_filename}.tar.gz"
      $java_home = "${java_dir}/jdk1.8.0"
      }
    '7':{
      $javaDownloadURI = "http://download.oracle.com/otn-pub/java/jdk/7/jdk-7-linux-${plat_filename}.tar.gz"
      $java_home = "${java_dir}/jdk1.7.0"
      }
    default:{
      fail("Unsupported java_version: ${java_version}. Implement me?")
      }
    }
  
    $installerFilename = inline_template('<%= File.basename(@javaDownloadURI) %>')
    if ( $::use_cache ){
      notify { 'Using local cache for oracle java': }
      file { "${java_dir}/${installerFilename}":
      source => "puppet:///modules/logstatsh/${installerFilename}",
    }
    
    exec { 'get_jdk_installer':
      cwd => $java_dir,
      creates => "${java_dir}/jdk_from_cache",
      command => 'touch jdk_from_cache',
      require => File["${java_dir}/jdk-${java_version}-linux-x64.tar.gz"],
    }
  }   else {
    exec { 'get_jdk_installer':
      cwd => $java_dir,
      creates => "${java_dir}/${installerFilename}",
      command => "wget -c --no-cookies --no-check-certificate --header \"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com\" --header \"Cookie: oraclelicense=accept-securebackup-cookie\" \"${javaDownloadURI}\" -O ${installerFilename}",
      timeout => 1200,
    }
    
    file { "${java_dir}/${installerFilename}":
      mode => '0755',
      owner => root,
      group => root,
      require => Exec['get_jdk_installer'],
    }
  }
    if ( $java_version in [ '7', '8' ] ) {
    exec { 'extract_jdk':
      cwd => "${java_dir}/",
      command => "tar -xf ${installerFilename}",
      creates => $java_home,
      require => Exec['get_jdk_installer'],
    }
  }
    if ( $java_version in [ '7', '8' ] ) {
      exec { "set_java_home":
      command => "echo 'export JAVA_HOME=${java_home}'>> ${env_path}",
      unless => "grep 'JAVA_HOME=${java_home}' ${env_path}",
      require => Exec["extract_jdk"],
    }
  }
    exec { "java_path":
      command => "echo 'export PATH=\$JAVA_HOME/bin:\$PATH' >> ${env_path}",
      unless => "grep 'export PATH=\$JAVA_HOME/bin:\$PATH' ${env_path}",
      require => Exec["set_java_home"],
    }
    
    exec { "set_env":
      command => "bash -c 'source ${env_path}'",
      require => Exec["java_path"];
    }
  
  
  
}
