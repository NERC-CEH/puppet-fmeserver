class fmeserver::install (
  $install_source    = $fmeserver::install_source,
  $home_directory    = $fmeserver::home_directory,
  $install_directory = $fmeserver::install_directory,
  $user              = $fmeserver::user,
  $group             = $fmeserver::group,
  $hostname          = $fmeserver::hostname,
  $timeout           = 600,
) {
  $install_media    = "${home_directory}/fme-server.run"
  $install_download = "/tmp/fme-server.run"
  $install_config   = "${home_directory}/install.cfg"

  file { $home_directory :
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0640',
  }

  include wget
  wget::fetch { $install_source :
    destination => $install_download,
  }

  file { $install_media: 
    source => $install_download,
    ensure => file,
    mode   => '0755',
  }

  file { $install_config :
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => template('fmeserver/install.cfg.erb'),
  }

  exec { 'install fme server' :
    command => "${install_media} -- --file ${install_config}",
    user    => $user,
    timeout => $timeout,
    require => File[$install_config],
    creates => $install_directory,
  }
}
