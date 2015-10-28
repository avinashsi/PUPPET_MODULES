# Java #

This is the java module. It provides...

![Architecture](https://github.com/avinashsi/images/blob/master/Sun-Java-JDK_1.jpg)



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

* Installs and configure Java.

###Beginning with Java

You haves to pass in parameters from nodes.pp file in order to run this module. Below is the e.g. showing that

```puppet

node "node1"
{
  include java
  java::instance{'node1':
  java_version  => '8',
 }

}

```


###Parameters

The following parameters are available in the java module which are needed to be defined in nodes.pp file


####`java_version`

Define java_version here for oracle java 7 or 8 .It will automatically deploy java and set JAVA_HOME environment vaiable.



##Limitations

This module has been built on and tested against Puppet 2.7 and higher.

The module has been tested on:

* RedHat Enterprise Linux 5/6
* CentOS 5/6
* Debian


##Development

Puppet Labs modules on the Puppet Forge are open projects, and community
contributions are essential for keeping them great. We can�t access the
huge number of platforms and myriad of hardware, software, and deployment
configurations that Puppet is intended to serve.

We want to keep it as easy as possible to contribute changes so that our
modules work in your environment. There are a few guidelines that we need
contributors to follow so that we can have a chance of keeping on top of things.

You can read the complete module contribution guide [on the Puppet Labs wiki.](http://projects.puppetlabs.com/projects/module-site/wiki/Module_contributing)
All trademarks and registered trademarks are the property of their respective owners.
