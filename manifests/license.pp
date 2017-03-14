# == Class: fmeserver::license
#
# Provisions a node to license its local installation of fme server (require
# fmeserver to be defined)
#
# This class optionally manages the dependencies required to license fmeserver.

# === Parameters
#
# [*license_server*]       The location of a licenser server which fmeserver should use
# [*libgtkglext1_version*] The version of gtkglext1 to manage (false stops install)
# [*libjpeg62_version*]    The version of libjpeg62 to manage (false stops install)
#
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
