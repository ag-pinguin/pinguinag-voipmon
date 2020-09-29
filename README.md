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

The module also supports arbritrary config via custom_config hash:

``` puppet
voipmonitor::sniffer { 'my-first-sniffer':
  ensure             => running
  custom_config => {
    somekey => "somevalue"
  }
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
  server           => true,
  server_bind      => '0.0.0.0',
  server_bind_port => '60050',
  server_password  => 'mypassword'
  mysqlcompress    => 'yes',
  mysqldb          => 'mydb',
  mysqlhost        => 'myhost',
  mysqlloadconfig  => 'yes',
  mysqlpassword    => 'PaSSW0Rd',
  mysqlport        => '3306'
  mysqlusername    => 'myuser'
}
```
