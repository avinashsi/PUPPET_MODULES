# Tomcat #

This is the tomcat module. It provides following


####Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with tomcat](#setup)
    * [What tomcat affects](#what-tomcat-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with tomcat](#beginning-with-tomcat)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

##Overview

The tomcat module handles installing, configuring, and running tomcat across range of operating system.

	
##Setup

###What tomcat affects

* Installs and configure tomcat .
* Configures tomcat on nodes as service. 


###Beginning with percona_clusters

You haves to pass in parameters from nodes.pp file in order to run this module. Below is the e.g. showing that

```puppet

node "node1.com"
{

    include tomcat
        tomcat::instance{'node1':
        tomcat_version => '7',
        connector_port => '8080',
        redirectPort => '8443',
        server_port => '8005',
        connector_ajp_port => '8009',
   
       }
}
```


###Parameters

The following parameters are available in the tomcat module which are needed to be defined in nodes.pp file

####`tomcat_version`

Specify $tomcat_version which you want install i.e. 7 or 8. Please note this is mandatory field


####`connector_port`

Specify $connector_port on which you want to run tomcat default value is 8080.

####`redirectPort`

Specify the $redirectPort on which you want to run tomcat default value is 8443.

####`server_port`

Specify the $server_port for the tomcat default value is 8005.

####`connector_ajp_port`

Specify the $connector_ajp_port on which you want to run tomcat default value is 8009.


##Limitations

This module has been built on and tested against Puppet 2.7 and higher.

The module has been tested on:

* RedHat Enterprise Linux 5/6
* CentOS 5/6
* Debian

##Development

Puppet Labs modules on the Puppet Forge are open projects, and community
contributions are essential for keeping them great. We can't access the
huge number of platforms and myriad of hardware, software, and deployment
configurations that Puppet is intended to serve.

We want to keep it as easy as possible to contribute changes so that our
modules work in your environment. There are a few guidelines that we need
contributors to follow so that we can have a chance of keeping on top of things.

You can read the complete module contribution guide [on the Puppet Labs wiki.](http://projects.puppetlabs.com/projects/module-site/wiki/Module_contributing)


All trademarks and registered trademarks are the property of their respective owners.
