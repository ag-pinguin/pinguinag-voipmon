#Creates a sniffer
define voipmonitor::sniffer (
  String $id_sensor,
  String $interface,
  String $managerport,
  String $server_destination,
  String $server_password,
  Boolean $enable         = lookup('voipmonitor::sniffer::enable'),
  String $ensure          = lookup('voipmonitor::sniffer::ensure'),
  String $spooldir_prefix = lookup('voipmonitor::spooldir_prefix')
) {
  $spooldir = "${spooldir_prefix}{$id_sensor}"
  file { $spooldir:
    ensure => directory
  }
  class { 'voipmonitor::config':
    config_filename    => "/etc/voipmonitor-${id_sensor}.conf",
    id_sensor          => $id_sensor,
    interface          => $interface,
    mangerport         => $managerport,
    server_destination => $server_destination,
    server_password    => $server_password
  }
  voipmonitor::service { "voipmonitor-${id_sensor}":
    ensure => $ensure,
    enable => $enable
  }
}
