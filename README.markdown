# FME Server

This module handles the management and installation of [Safe Software - FME Server](http://www.safe.com/fme/fme-server). 

## Module Description
This puppet module will obtain and automatically install FME Server for Linux. It will configure the server to run 
as a specific user and correctly configure the [run levels](http://docs.safe.com/fme/html/FME_Server_Documentation/Default.htm#AdminGuide/Installing_FME_Server_As_System_Service.htm) as required.

# Setup

## What FME Server affects

- Management of an FME user
- Installation of fme server
- Service management of the various fme services

# Usage

Install fme server by obtaining the installtion media from a custom location

    class { 'fmeserver' :
      install_source => 'http://your.local.filestore/fme-server-b15515-linux-x64.run',
    }

License the fme server installation against your floating license server:

    class { 'fmeserver::license' :
      license_server => 'your.licserver',
    }

Enable SDE Formats

    class { 'fmeserver::arcsde' :
      path => '/opt/esri/arcsde93',
    }

# Limitations

This module only covers the FME Server **for linux** and has been tested with version 2015 on Ubuntu 14.04

# RSpec Testing

[![Build Status](https://travis-ci.org/NERC-CEH/puppet-fmeserver.svg?branch=master)](https://travis-ci.org/NERC-CEH/puppet-fmeserver)

Using [rspec-puppet](http://rspec-puppet.com/)

`make` to run tests

# Contributors

Rod Scott - rjsc@ceh.ac.uk

Christopher Johnson - cjohn@ceh.ac.uk
