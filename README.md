### Configure sniffer
``` puppet
class { 'voipmonitor:'
  server => false
}
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

### Configure server
This does not install php prerequisites, to allow you to configure apache, php,
etc yourself.

PHP prereqs needed:
gd
mysql
mcrypt
mbstring
zip

``` puppet
class { 'voipmonitor':
  server          => true,
  mysqlcompress   => yes,
  mysqldb         => mydb,
  mysqlhost       => myhost,
  mysqlloadconfig => yes,
  mysqlpassword   => 'PaSSW0Rd',
  mysqlport       => '3306'
  mysqlusername   => 'myuser'
}
```
