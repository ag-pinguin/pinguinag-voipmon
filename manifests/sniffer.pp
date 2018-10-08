#Creates a sniffer
define voipmonitor::sniffer (
  Boolean $enable         = lookup('voipmonitor::sniffer::enable'),
  String $ensure          = lookup('voipmonitor::sniffer::ensure'),
  String $spooldir_prefix = lookup('voipmonitor::spooldir_prefix')
) {
  $spooldir = "${spooldir_prefix}{$id_sensor}"
  file { $spooldir:
    ensure => directory
  }
  class { 'voipmonitor::config':
    config_filename => "/etc/voipmonitor-${id_sensor}.conf"
  }
  voipmonitor::service { "voipmonitor-${id_sensor}":
    ensure => $ensure,
    enable => $enable
  }
}
