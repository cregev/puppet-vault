#puppet-vault


##Overview

The Vault module installs, configures, and manages the Vault service.

##Module Description

The vault module handles installing, configuring, and running Vault by HashiCorp.

##Setup

###Beginning with vault

`include '::vault'` is enough to get you up and running.

##Usage

All interaction with the vault module can be done through the main vault class. This means you can simply toggle the options in `::vault` to have full functionality of the module.

###I just want Vault, what's the minimum I need?

```puppet
include '::vault'
```

##Reference

###Classes

####Public Classes

* vault: Main class, includes all other classes.

####Private Classes

* vault::config: Handles the configuration file.
* vault::install: Handles the packages.
* vault::service: Handles the service.


###Contributors

Costya Revegv