# == [Class vault::params]
# [!] This class is called from vault::init[!]
# This class is meant to be called from vault
# It sets variables according to platform


class vault::params {
  # {Vault Configs}
  $package_name          = 'vault'
  $download_url_base     = 'https://dl.bintray.com/mitchellh/vault/#'
  $download_extension    = 'zip'
  $version               = '0.1.2'
  $config_file           = 'vault/config.hcl.erb'
  # {Ports for Vault}
  $listner_port          = '8230'
  $backend_port          = '8500'
  # {Listener,Backend address}
  $backend_address       = '127.0.0.1'
  $listner_address       = '127.0.0.1'
  # {Limits}
  $limits_memlock        = 'unlimited'
  $limits_nofile         = '64000'


  case $::architecture {
    'x86_64', 'amd64': { $arch = 'amd64' }
    'i386':            { $arch = '386'   }
    default:           {
      fail("Unsupported kernel architecture: ${::architecture}")}
  }
  $os = downcase($::kernel)
  

  if !($::osfamily in ['Ubuntu', 'CentOS' , 'RedHat' , 'Fedora', 'Debian']) {
    fail("${module_name} does not support your osfamily ${::osfamily}")
  }
  
  $init_style = $::operatingsystem ? {
    'Ubuntu'  => $::lsbdistrelease ? {
      '8.04'  => 'init_d',
      '15.04' => 'systemd',
      default => 'upstart'
    },
    /CentOS|RedHat/      => $::operatingsystemmajrelease ? {
      /(4|5|6)/ => 'init_d',
      default   => 'systemd',
    },
    'Fedora'             => $::operatingsystemmajrelease ? {
      /(12|13|14)/ => 'init_d',
      default      => 'systemd',
    },
    'Debian'             => $::operatingsystemmajrelease ? {
      /(4|5|6|7)/ => 'init_d',
      default     => 'systemd'
    },
    default => 'init_d'
  }
  # {User and Group for the files and user to run the service as}
  case $::kernel {
    'Linux': {
      $vault_user  = 'vault'
      $vault_group = 'vault'
    }
    default: {
      fail("\"${module_name}\" provides no user/group default value
           for \"${::kernel}\"")
    }
  }
}

