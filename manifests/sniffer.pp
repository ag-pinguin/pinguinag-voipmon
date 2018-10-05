#Creates a sniffer
define voipmonitor::sniffer (
  String $absolute_timeout             = lookup('voipmonitor::sniffer::absolute_timeout'),
  String $autocleanmingb               = lookup('voipmonitor::sniffer::autocleanmingb'),
  String $autocleanspool               = lookup('voipmonitor::sniffer::autocleanspool'),
  String $autocleanspoolminpercent     = lookup('voipmonitor::sniffer::autocleanspoolminpercent'),
  String $cdr_rtpport                  = lookup('voipmonitor::sniffer::cdr_rtpport'),
  String $cdr_sipport                  = lookup('voipmonitor::sniffer::cdr_sipport'),
  String $cdrproxy                     = lookup('voipmonitor::sniffer::cdrproxy'),
  String $destroy_call_at_bye          = lookup('voipmonitor::sniffer::destroy_call_at_bye'),
  String $dscp                         = lookup('voipmonitor::sniffer::dscp'),
  Boolean $enable                      = lookup('voipmonitor::sniffer::enable'),
  String $ensure                       = lookup('voipmonitor::sniffer::ensure'),
  String $id_sensor                    = lookup('voipmonitor::sniffer::id_sensor'),
  String $interface                    = lookup('voipmonitor::sniffer::interface'),
  String $managerip                    = lookup('voipmonitor::sniffer::managerip'),
  String $managerport                  = lookup('voipmonitor::sniffer::managerport'),
  String $max_buffer_mem               = lookup('voipmonitor::sniffer::max_buffer_mem'),
  String $maxpoolsize_2                = lookup('voipmonitor::sniffer::maxpoolsize_2'),
  String $maxpoolsize                  = lookup('voipmonitor::sniffer::maxpoolsize'),
  String $mos_g729                     = lookup('voipmonitor::sniffer::mos_g729'),
  String $mos_lqo_bin                  = lookup('voipmonitor::sniffer::mos_lqo_bin'),
  String $mos_lqo_ref                  = lookup('voipmonitor::sniffer::mos_lqo_ref'),
  String $mos_lqo_ref16                = lookup('voipmonitor::sniffer::mos_lqo_ref16'),
  String $mos_lqo                      = lookup('voipmonitor::sniffer::mos_lqo'),
  String $nocdr                        = lookup('voipmonitor::sniffer::nocdr'),
  String $ogg_quality                  = lookup('voipmonitor::sniffer::ogg_quality'),
  String $onewaytimeout                = lookup('voipmonitor::sniffer::onewaytimeout'),
  String $packetbuffer_compress_ratio  = lookup('voipmonitor::sniffer::packetbuffer_compress_ratio'),
  String $packetbuffer_compress        = lookup('voipmonitor::sniffer::packetbuffer_compress'),
  String $packetbuffer_enable          = lookup('voipmonitor::sniffer::packetbuffer_enable'),
  String $pcap_dump_asyncwrite         = lookup('voipmonitor::sniffer::pcap_dump_asyncwrite'),
  String $pcap_dump_bufflength         = lookup('voipmonitor::sniffer::pcap_dump_bufflength'),
  String $pcap_dump_writethreads_max   = lookup('voipmonitor::sniffer::pcap_dump_writethreads_max'),
  String $pcap_dump_writethreads       = lookup('voipmonitor::sniffer::pcap_dump_writethreads'),
  String $pcap_dump_zip_rtp            = lookup('voipmonitor::sniffer::pcap_dump_zip_rtp'),
  String $pcap_dump_zip                = lookup('voipmonitor::sniffer::pcap_dump_zip'),
  String $pcap_dump_ziplevel_sip       = lookup('voipmonitor::sniffer::pcap_dump_ziplevel_sip'),
  String $promisc                      = lookup('voipmonitor::sniffer::promisc'),
  String $ringbuffer                   = lookup('voipmonitor::sniffer::ringbuffer'),
  String $saveaudio_stereo             = lookup('voipmonitor::sniffer::saveaudio_stereo'),
  String $savegraph                    = lookup('voipmonitor::sniffer::savegraph'),
  String $savertcp                     = lookup('voipmonitor::sniffer::savertcp'),
  String $savertp                      = lookup('voipmonitor::sniffer::savertp'),
  String $savesip                      = lookup('voipmonitor::sniffer::savesip'),
  String $server_destination_port      = lookup('voipmonitor::sniffer::server_destination_port'),
  String $server_destination           = lookup('voipmonitor::sniffer::server_destination'),
  String $server_password              = lookup('voipmonitor::sniffer::server_password'),
  String $sip_options                  = lookup('voipmonitor::sniffer::sip_options'),
  String $sip_register_active_nologbin = lookup('voipmonitor::sniffer::sip_register_active_nologbin'),
  String $sip_register_timeout         = lookup('voipmonitor::sniffer::sip_register_timeout'),
  String $sip_register                 = lookup('voipmonitor::sniffer::sip_register'),
  String $sipport                      = lookup('voipmonitor::sniffer::sipport'),
  String $spooldir_prefix              = lookup('voipmonitor::sniffer::spooldir_prefix'),
  String $tar_compress_graph           = lookup('voipmonitor::sniffer::tar_compress_graph'),
  String $tar_compress_rtp             = lookup('voipmonitor::sniffer::tar_compress_rtp'),
  String $tar_compress_sip             = lookup('voipmonitor::sniffer::tar_compress_sip'),
  String $tar_graph_level              = lookup('voipmonitor::sniffer::tar_graph_level'),
  String $tar_maxthreads               = lookup('voipmonitor::sniffer::tar_maxthreads'),
  String $tar_rtp_level                = lookup('voipmonitor::sniffer::tar_rtp_level'),
  String $tar_sip_level                = lookup('voipmonitor::sniffer::tar_sip_level'),
  String $tar                          = lookup('voipmonitor::sniffer::tar'),
  Boolean $utc                         = lookup('voipmonitor::sniffer::utc'),
) {
  $spooldir = "${spooldir_prefix}{$id_sensor}"
  file { [$spooldir_prefix, $spooldir]:
    ensure => directory
  }
  file { "/etc/voipmonitor-${id_sensor}.conf":
    ensure  => present,
    content => template('sniffer/voipmonitor.conf.erb'),
    notify  => Service["voipmonitor-${id_sensor}"]
  }
  voipmonitor::service { "voipmonitor-${id_sensor}": }
}
