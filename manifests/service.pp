# == Define: fmeserver::service
#
# This define helps manage the fme services. It should not be refered to
# outside of this module
#
define fmeserver::service (
  $start_priority,
  $stop_priority,
  $user              = $fmeserver::user,
  $install_directory = $fmeserver::install_directory,
) {
  $init_script = "/etc/init.d/${name}"

  $start_runlevel = $::osfamily ? {
    'Debian' => '2',
    'RedHat' => '5',
  }

  $kill_runlevel = '6'

  file { $init_script :
    ensure => file,
    mode   => '0755',
    source => "${install_directory}/Server/startup/${name}",
  }

  file { "/etc/rc${start_runlevel}.d/S${start_priority}${name}" :
    ensure  => link,
    target  => $init_script,
    before  => Service[$name],
    require => File[$init_script],
  }

  file { "/etc/rc${kill_runlevel}.d/K${stop_priority}${name}" :
    ensure  => link,
    target  => $init_script,
    before  => Service[$name],
    require => File[$init_script],
  }

  service { $name :
    ensure   => running,
    provider => init,
  }
}
