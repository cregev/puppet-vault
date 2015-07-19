# == [Class: vault]
#
# Installs, configures, and manages vault
#
# == [Parameters]
#--------------
# {version}
# Specify version of vault to download.
#
# [*init_style*]
#   What style of init your system uses.
#
# === [Authors]
#
# * Costya Regev <mailto:costya.regev@me.com>

class vault (
# {Grups & Users}
  $manage_user           = true,
  $vault_user            = $vault::params::vault_user,
  $vault_group           = $vault::params::vault_group,
  $manage_group          = true,
# {Params}
  $arch                  = $vault::params::arch,
  $version               = $vault::params::version,
  $os                    = $vault::params::os,
  $download_url_base     = $vault::params::download_url_base,
  $download_extension    = $vault::params::download_extension,
  $package_name          = $vault::params::package_name,
  $package_ensure        = $vault::params::package_ensure,
  $listner_port          = $vault::params::listner_port,
  $backend_port          = $vault::params::backend_port,
  $backend_address       = $vault::params::backend_address,
  $listner_address       = $vault::params::listner_address,
  $limits_memlock        = $vault::params::limits_memlock,
  $limits_nofile         = $vault::params::limits_nofile,
  $config_file           = $vault::params::config_file,
# {Directories}
  $install_dir           = '/usr/local/vault',
  $version_dir           = "${install_dir}-${version}/",
  $logs_dir              = '/var/log/vault',
  $config_dir            = '/etc/vault',
  $pid_path              = "${install_dir}/run",
  $pid_file              = "${pid_path}/vault.pid",
# {Service Params}
  $service_name          = 'vault',
  $service_enable        = true,
  $service_ensure        = 'running',
  $service_manage        = true,
  $service_status        = true,
  $service_restart       = true,
  $init_style            = $vault::params::init_style,
# {Not Sure we need them}
  $download_url          = undef,
) inherits vault::params {

include 'stdlib'
# {Full download URL}
  $real_download_url = pick($download_url, "${download_url_base}${version}_${os}_${arch}.${download_extension}")
# Vault url Example: 
# https://dl.bintray.com/mitchellh/vault/#vault_0.1.2_linux_amd64.zip ... just an example.

# {Validate Paths & Booleans}
  # {Paths}
  validate_absolute_path($install_dir)
  validate_absolute_path($logs_dir)
  validate_absolute_path($config_dir)
  validate_absolute_path($pid_path)
  validate_absolute_path($pid_file)
  validate_absolute_path($version_dir)
  # {Booleans}
  validate_bool($manage_user)
  validate_bool($manage_service)
  validate_bool($service_status)
  validate_bool($service_restart)
  validate_bool($service_enable)
  validate_bool($service_ensure)


  # {Anchor}
  anchor { 'vault::begin': } ->
  class { '::vault::config': } ->
  class { '::vault::install': } ~>
  class { '::vault::service': } ->
  anchor { 'vault::end': }
}
