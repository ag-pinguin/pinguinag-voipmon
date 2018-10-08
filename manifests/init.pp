# Installs and configures voipmon
class voipmonitor (
  Boolean $server,
  Optional[String] $mysqlcompress   = undef,
  Optional[String] $mysqldb         = undef,
  Optional[String] $mysqlhost       = undef,
  Optional[String] $mysqlloadconfig = undef,
  Optional[String] $mysqlpassword   = undef,
  Optional[String] $mysqlport       = undef,
  Optional[String] $mysqlusername   = undef,
){
  if $server {
    class { 'voipmonitor::server::install': }
    -> voipmonitor::service { 'voipmonitor':
      ensure => running,
      enable => true,
    }
    -> class { 'voipmonitor::config':
      config_filename => '/etc/voipmonitor.conf',
      mysqlcompress   => $mysqlcompress,
      mysqldb         => $mysqldb,
      mysqlhost       => $mysqlhost,
      mysqlloadconfig => $mysqlloadconfig,
      mysqlpassword   => $mysqlpassword,
      mysqlport       => $mysqlport,
      mysqlusername   => $mysqlusername,
    }
  } else {
    class { 'voipmonitor::sniffer::install': }
  }
}
