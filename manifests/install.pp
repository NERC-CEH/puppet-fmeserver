# == Class: fmeserver::install
#
# This class manages the installation of fme server. It should not be refered
# to outside of this module.
#
class fmeserver::install (
  $install_source    = $fmeserver::install_source,
  $home_directory    = $fmeserver::home_directory,
  $install_directory = $fmeserver::install_directory,
  $user              = $fmeserver::user,
  $admin_username    = $fmeserver::admin_username,
  $admin_password    = $fmeserver::admin_password,
  $group             = $fmeserver::group,
  $hostname          = $fmeserver::hostname,
  $timeout           = 600,
  $zip_version       = $fmeserver::zip_version,
  $lsb_core_version  = $fmeserver::lsb_core_version,
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

  # If an install source has been specified then we will attempt to download it
  if $install_source {
    include wget
    wget::fetch { $install_source :
      destination => $install_download,
    }

    file { $install_media :
      source  => $install_download,
      ensure  => file,
      mode    => '0755',
      require => Wget::Fetch[$install_source],
      before  => Exec['install_fmeserver'],
    }
  }

  # The installer requires lsb-core and zip to be installed
  if $lsb_core_version {
    package { 'lsb-core' :
      ensure => $lsb_core_version,
      before => Exec['install_fmeserver'],
    }
  }

  if $zip_version {
    package { 'zip' :
      ensure => $zip_version,
      before => Exec['install_fmeserver'],
    }
  }

  file { $install_config :
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => template('fmeserver/install.cfg.erb'),
  }

  exec { 'install_fmeserver' :
    command => "${install_media} -- --file ${install_config}",
    user    => $user,
    timeout => $timeout,
    require => File[$install_config],
    creates => $install_directory,
  }

  file { "$install_config/Server/fmeEngineConfig.txt" :
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => template('fmeserver/fmeEngineConfig.erb'),
  }
}
