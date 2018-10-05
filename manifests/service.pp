# Create service file
define voipmonitor::service(
  String $ensure,
  Boolean $enable,
  String $servicename = $title,
) {
  file { "/etc/init.d/${servicename}":
    ensure  => present,
    content => template('voipmonitor/init.d.erb'),
    mode    => '0744',
    notify  => Service[$servicename]
  }
  service { $servicename:
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => false,
    status     => "/usr/bin/test -f /var/run/${servicename}.pid"
  }
}
