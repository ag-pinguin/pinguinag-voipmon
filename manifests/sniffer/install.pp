# Installs voipmon sniffer from official binaries
class voipmonitor::sniffer::install (
  String $base_url,
  String $install_location,
){
  case $facts['os']['architecture'] {
    'x86_64': { $arch = '64bit' }
    default:  { $arch = '32bit' }
  }
  file { $install_location:
    ensure => directory
  }
  $filename = "current-stable-sniffer-static-${arch}.tar.gz"
  file { "${install_location}/${filename}":
    ensure => present,
    source => "http://${base_url}/${filename}"
  }
  exec { 'install script':
    command => "/bin/bash ${install_location}/install-script.sh && touch ${install_location}/.installed"
    creates => "${install_location}/.installed"
  }
}
