# Installs and configures voipmon
class voipmonitor (
  Boolean $server,
){
  if $server {
  } else {
    class { 'voipmonitor::sniffer::install': }
  }
}
