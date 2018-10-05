### Configure sniffer
``` puppet
voipmonitor::sniffer { 'my-first-sniffer':
  ensure             => running
  id_sensor          => '1',
  interface          => 'eno2',
  server_destination => '1.2.3.4',
  server_password    => 'SuPeRsEcReT',
  managerport        => '1234',
  spooldir           => '/my/data/directory'
}
```
