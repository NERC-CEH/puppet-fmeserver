class fmeserver::license (
  $license_server,
  $libgtkglext1_version = installed,
  $libjpeg62_version    = installed,
) {
  if ! defined(Class['fmeserver']) {
    fail('You must include the fmeserver before you attempt to license')
  }

  $fmelicensingassistant = "${fmeserver::install_directory}/Server/fme/fmelicensingassistant"

  # Install the required packages if requested
  if $libgtkglext1_version {
    package { 'libgtkglext1' :
      ensure => $libgtkglext1_version,
      before => Exec['license_fme'],
    }
  }

  if $libjpeg62_version {
    package { 'libjpeg62':
      ensure => $libjpeg62_version,
      before => Exec['license_fme'],
    }
  }

  # Store which server the fme server is licensed with. If this changes, we can
  # notify the exec block.
  file { "${fmeserver::home_directory}/fmeserver.licserver" :
    content => $license_server,
    notify  => Exec['license_fme'],
  }

  exec { 'license_fme' :
    command     => "${fmelicensingassistant} --floating ${license_server} server",
    refreshonly => true,
    require     => Class['fmeserver'],
  }
} 
