# Create service file
define voipmonitor::service(
  String $servicename = $title,
) {
  file { "/etc/init.d/${servicename}":
    ensure  => present,
    mode    => '0744'
    content => template('init.d.erb')
  }
  service { $servicename:
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => false,
    provider   => 'init.d'
  }
}
