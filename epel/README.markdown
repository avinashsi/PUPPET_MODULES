
####Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with epel](#setup)
    * [What epel affects](#what-epel-affects)
    * [Beginning with epel](#beginning-with-epel)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Dependencies - ssl cerrtificate ](#Dependencies)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

##Overview

The puppet module for managing the installation of epel repositry.(EPEL)Extra Packages for Enterprise Linux) 
is open source and free community based repository project from Fedora team which provides 100% high 
quality add-on software packages for Linux distribution including RHEL (Red Hat Enterprise Linux), 
CentOS, and Scientific Linux.


##Setup

###What epel affects

* epel package.


###Beginning with epel

`include 'epel'` in manifests/nodes.pp:

```puppet
node "epel.vagrant.com" 
    {
        include epel 
   		
    }
```

##Usage

All interaction with the epel module can do be done through the main epel class.
This means you can simply toggle the options in `epel` to have full functionality of the module.



##Limitations

This module has been built on and tested against Puppet 2.7 and higher.

The module has been tested on:

* RedHat Enterprise Linux 5/6
* CentOS 5/6


##Development

Puppet Labs modules on the Puppet Forge are open projects, and community
contributions are essential for keeping them great. We can’t access the
huge number of platforms and myriad of hardware, software, and deployment
configurations that Puppet is intended to serve.

We want to keep it as easy as possible to contribute changes so that our
modules work in your environment. There are a few guidelines that we need
contributors to follow so that we can have a chance of keeping on top of things.

You can read the complete module contribution guide [on the Puppet Labs wiki.](http://projects.puppetlabs.com/projects/module-site/wiki/Module_contributing)


