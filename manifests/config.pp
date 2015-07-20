# == [Class vault::config]
#
# [!] This class is called from vault::init to configure the init_style [!]


class vault::config inherits vault (
  $init_conf_upstart = '/etc/init/vault.conf',
  $init_conf_genral  = '/etc/init.d/vault',
  $init_conf_systemd = '/lib/systemd/system/vault.service'
) inherits vault {

  # {Configure Init_style for different OS}
  if $vault::init_style {
    case $vault::init_style {
      'upstart' : {
        file { "${init_conf_upstart}":
          mode    => '0444',
          owner   => $vault::vault_user,
          group   => $vault::vault_group,
          content => template("${module_name}/vault.conf.erb")
        }
      }
      'init_d' : {
        file { "${init_conf_genral}":
          mode    => '0555',
          owner   => $vault::vault_user,
          group   => $vault::vault_group,
          content => template("${module_name}/vault.init.erb")
        }
      }
      'systemd' : {
        file { "${init_conf_systemd}":
          mode    => '0644',
          owner   => $vault::vault_user,
          group   => $vault::vault_group,
          content => template("${module_name}/vault.systemd.erb")
        }
      }
      default : {
        fail("Init script can not be created for ${vault::init_style}")
      }
    }
  }
}

