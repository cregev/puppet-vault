#puppet-vault


##Overview

The Vault module installs, configures, and manages the Vault service.

##Module Description

The vault module handles installing, configuring, and running [Vault][1] by HashiCorp.

### Modules:

* stdlib >= 4.2.0
* archive >= 0.3.0

### Platform:

* 14.04LTS.

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

* vault::config: Handles the configuration for the init_style.
* vault::install: Handles the installation of directories,users,groups,config files ...
* vault::service: Handles the service.



###Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Commit your changes.
4. Submit a Pull Request using Github


###License and Authors


- Author: [CostyaRegev][3] (<Costya.regev@me.com>)

[1]: https://vaultproject.io/
[2]: https://github.com/hashicorp/vault
[3]: https://github.com/CostyaRegev
