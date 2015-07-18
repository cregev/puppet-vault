# == [Class vault::config]
#
# [!] This class is called from vault::init to install the config file [!]


class vault::config (
  $init_user = 'root',
  $init_conf_ubuntu = '/etc/init/vault.conf',
  $init_conf_genral = '/etc/init.d/vault') inherits vault {

  # {Configure Init_style for different OS}
  if $vaulta::init_style {
    case $vault::init_style {
      'upstart' : {
        file { "${init_conf_ubuntu}":
          mode    => '0444',
          owner   => $init_user,
          group   => $init_user,
          content => template("${module_name}/vault.conf.erb"),
        }
      }
      'init_d' : {
        file { "${init_conf_genral}":
          mode    => '0555',
          owner   => $init_user,
          group   => $init_user,
          content => template("${module_name}/vault.init.erb")
        }
      }
      default : {
        fail("Init script can not be created for ${vault::init_style}")
      }
    }
  }
}

