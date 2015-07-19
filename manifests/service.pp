# == [Class vault::service]
# == [!] This class is called from vault::init to install Vault serivce [!]
# It ensure the service is running.
# [*ensure*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>. If set to <tt>absent</tt>:
# [*enable*]
# Whether a service should be enabled to start at boot
# [*hasstatus]
# Declare whether the service's init script has a status
# [*hasrestart]
# Specify that an init script has a `restart...


class vault::service inherits vault {

  if ! ($vault::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }
  if $vault::service_manage{
    service { "${vault::service_name}":
      ensure     => $vault::service_ensure,
      name       => $vault::service_name,
      enable     => $vault::service_enable,
      hasstatus  => $vault::service_status,
      hasrestart => $vault::service_restart,
    }
  }
}
