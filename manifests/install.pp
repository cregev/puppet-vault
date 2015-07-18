# == [Class vault::intall]
# == [!] This class is called from vault::init to install directories,users,groups,config files ...etc. [!]
class vault::install inherits vault {

  include 'archive' #Include archive to Download & Extract Vault

  # {Create Directories}
  $vault_dirs = [ $vault::install_dir, $vault::logs_dir, $vault::config_dir, $vault::pid_path , $vault::version_dir]
  file { "${vault_dirs}":
    ensure => "directory",
    owner  => $vault::vault_user,
    group  => $vault::vault_group,
    mode   => '0640',
    recurse => true,
  }
  # {Create Config File}
  file { "${vault::conf_dir}/config.hcl":
    ensure  => 'file',
    mode   => '0600',
    content => template("${module_name}/config.hcl.erb"),
    owner   => $vault::vault_user,
    group   => $vault::vault_group,
    require => File["${vault_dirs}"],
    notify  => Service["${vault::service_name}"]
  }
    # {Create Pid file}
  file { $vault::pid_file:
    ensure => "file",
    owner  => $vault::vault_user,
    group  => $vault::vault_group,
    mode   => '0750',
    require => File["${vault_dirs}"]
  }
    # {Create Group & User}
  if $vault::manage_user {
    user { "${vault::vault_user}":
      ensure => 'present',
      shell => '/bin/bash',
      managehome => true
      }
  }
  if $vault::manage_group {
      group { "${vault::vault_group}":
      ensure => 'present',
      name => $vault::vault_group,
      
      }
  }
    # {Download & Extract Vault and cleanup zip file}
  ensure_packages(['unzip'])
  archive { "Vault Download & Extract":
      source        => $vault::real_download_url,
      user          => $vault::vault_user,
      group         => $vault::vault_group,
      extract       => true,
      extract_path  => $vault::version_dir,
      cleanup       => true,
    }
    # { Link Version dir to Install dir.}
  file { "${vault::version_dir}":
    ensure => 'link',
    target => "${vault::install_dir}",
  }
}
