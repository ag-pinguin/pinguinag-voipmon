# Installs voipmonitor server
class voipmonitor::server::install(
  Boolean $manage_cron,
  String $html_folder,
  String $install_location,
  String $spooldir_prefix,
  ) {
    # prerequisites without php modules
  $prereqs = [
    'mtr',
    'tshark',
    'gsfonts',
    'rrdtool',
    'librsvg2-bin',
  ]
  package { $prereqs:
    ensure => present
  }

  file { "${html_folder}/bin":
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
  }

  exec { 'get phantomjs':
    command => "/usr/bin/wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/phantomjs-2.1.1-x86_64.gz/download -O ${html_folder}/bin/phantomjs-2.1.1-x86_64.gz",
    creates => "${html_folder}/bin/phantomjs-2.1.1-x86_64.gz"
  }
  exec { 'get sox':
    command => "/usr/bin/wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/sox-x86_64.gz/download  -O ${html_folder}/bin/sox-x86_64.gz",
    creates => "${html_folder}/bin/sox-x86_64.gz"
  }
  exec { 'get tshark':
    command => "/usr/bin/wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/tshark-2.3.0.3-x86_64.gz/download -O ${html_folder}/bin/tshark-2.3.0.3-x86_64.gz",
    creates => "${html_folder}/bin/tshark-2.3.0.3-x86_64.gz"
  }
  exec { 'get mergecap':
    command => "/usr/bin/wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/mergecap-2.3.0.3-x86_64.gz/download -O ${html_folder}/bin/mergecap-2.3.0.3-x86_64.gz",
    creates => "${html_folder}/bin/mergecap-2.3.0.3-x86_64.gz"
  }
  exec { 'get t38':
    command => "/usr/bin/wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/t38_decode-2-i686.gz/download -O ${html_folder}/bin/t38_decode-2-i686.gz",
    creates => "${html_folder}/bin/t38_decode-2-i686.gz"
  }

  exec { 'unpack phantomjs-2.1.1-x86_64':
    command => '/bin/gunzip phantomjs-2.1.1-x86_64.gz && /bin/chmod +x phantomjs-2.1.1-x86_64',
    cwd     => "${html_folder}/bin",
    creates => "${html_folder}/bin/phantomjs-2.1.1-x86_64"
  }
  exec { 'unpack tshark-2.3.0.3-x86_64':
    command => '/bin/gunzip tshark-2.3.0.3-x86_64.gz && /bin/chmod +x tshark-2.3.0.3-x86_64',
    cwd     => "${html_folder}/bin",
    creates => "${html_folder}/bin/tshark-2.3.0.3-x86_64",
  }
  exec { 'unpack sox-x86_64':
    command => '/bin/gunzip sox-x86_64.gz && /bin/chmod +x sox-x86_64',
    cwd     => "${html_folder}/bin",
    creates => "${html_folder}/bin/sox-x86_64",
  }
  exec { 'unpack mergecap-2.3.0.3-x86_64':
    command => '/bin/gunzip mergecap-2.3.0.3-x86_64.gz && /bin/chmod +x mergecap-2.3.0.3-x86_64',
    cwd     => "${html_folder}/bin",
    creates => "${html_folder}/bin/mergecap-2.3.0.3-x86_64",
  }
  exec { 'unpack t38_decode-2-i686':
    command => '/bin/gunzip t38_decode-2-i686.gz && /bin/chmod +x t38_decode-2-i686',
    cwd     => "${html_folder}/bin",
    creates => "${html_folder}/bin/t38_decode-2-i686",
  }

  # IONcube
  exec { 'install IONcube':
    command => '/usr/bin/wget http://voipmonitor.org/ioncube/x86_64/ioncube_loader_lin_7.0.so -O /usr/lib/php/20151012/ioncube_loader_lin_7.0.so \
    && /bin/echo "zend_extension = /usr/lib/php/20151012/ioncube_loader_lin_7.0.so" > /etc/php/7.0/mods-available/ioncube.ini \
    && /bin/ln -s /etc/php/7.0/mods-available/ioncube.ini /etc/php/7.0/apache2/conf.d/01-ioncube.ini \
    && /bin/ln -s /etc/php/7.0/mods-available/ioncube.ini /etc/php/7.0/fpm/conf.d/01-ioncube.ini \
    && /bin/ln -s /etc/php/7.0/mods-available/ioncube.ini /etc/php/7.0/cli/conf.d/01-ioncube.ini',
    creates => '/usr/lib/php/20151012/ioncube_loader_lin_7.0.so',
  }

  # GUI
  exec { 'fetch GUI':
    command => '/usr/bin/wget "http://www.voipmonitor.org/download-gui?version=latest&major=5&phpver=56&festry" -O w.tar.gz',
    cwd     => $html_folder,
    creates => "${html_folder}/index.php"
  }
  -> exec { 'unpack gui':
    command => '/bin/tar -xf w.tar.gz --strip 1',
    creates => "${html_folder}/index.php",
    cwd     => $html_folder,
  }
  -> exec { 'delete old GUI archive':
    command => "/bin/rm ${html_folder}/w.tar.gz",
    onlyif  => "/usr/bin/test -f ${html_folder}/w.tar.gz",
  }

  # CRON
  if $manage_cron {
    cron { 'php cron':
      command => "/usr/bin/php ${html_folder}/php/run.php cron",
      user    => 'root',
      hour    => '*',
      minute  => '*/5'
    }
  }

  #
}
