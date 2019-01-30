# Installs voipmon sniffer from official binaries
class voipmonitor::sniffer::install (
  String $base_url,
  String $install_location,
  String $spooldir_prefix,
){
  # Step 0: make sure install location exists
  file { $install_location:
    ensure => directory
  }

  # Step 1: get binaries
  case $facts['os']['architecture'] {
    'amd64': { $arch = '64bit' }
    default:  { $arch = '32bit' }
  }
  $filename = "current-stable-sniffer-static-${arch}.tar.gz"
  exec { 'get binary':
    command => "/usr/bin/wget http://${base_url}/${filename} -O ${install_location}/${filename}",
    creates => "${install_location}/install-script.sh"
  }
  -> exec { 'unpack':
    command => "/bin/tar -xf ${filename} --strip 1",
    creates => "${install_location}/install-script.sh",
    cwd     => $install_location
  }
  -> exec { 'delete old file':
    command => "/bin/rm ${install_location}/${filename}",
    onlyif  => "/usr/bin/test -f ${install_location}/${filename}",
  }

  # Step 2: trigger install
  # We use a custom install script which is just like the regular install script
  # But does not create config files or service, since that is handled by puppet
  file { "${install_location}/custom-install-script":
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
    source => 'puppet:///modules/voipmonitor/custom-install-script.sh'
  }
  -> exec { 'install script':
    command => "/bin/bash ${install_location}/custom-install-script.sh && touch ${install_location}/.installed",
    creates => "${install_location}/.installed",
    cwd     => $install_location
  }

  # Step 3: make sure spooldir exists
  file { $spooldir_prefix:
    ensure => directory,
    owner  => 'www-data'
  }
}
