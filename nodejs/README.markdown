
####Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with nodejs](#setup)
    * [What nodejs affects](#what-nodejs-affects)
    * [Beginning with nodejs](#beginning-with-nodejs)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The puppet module for managing the installation of nodejs installation. Node.js® is a JavaScript runtime built on
Chrome's V8 JavaScript engine. Node.js uses an event-driven, non-blocking I/O model that makes it lightweight and 
efficient. Node.js' package ecosystem, npm, is the largest ecosystem of open source libraries in the world.


##Setup

###What nodejs affects

* nodejs package.


###Beginning with nodejs

`include 'nodejs'` in manifests/nodes.pp:

```puppet
node "nodejs.vagrant.com" 
    {
        include nodejs 
   		
    }
```

##Usage

All interaction with the nodejs module can do be done through the main nodejs class.
This means you can simply toggle the options in `nodejs` to have full functionality of the module.



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


