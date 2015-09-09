# == Class: fmeserver::arcsde
#
# This copies the ArcSDE SDK libraries which FME requires to enable the SDE30
# format.
#
# See http://fme.ly/8q8 for more details.
#
# === Parameters
#
# [*path*] The path to the arc sde client libraries installation
#
class fmeserver::arcsde (
  $path,
) {
  if ! defined(Class['fmeserver']) {
    fail('You must include the fmeserver before enable arcsde')
  }

  $ld_library_path = "${fmeserver::install_directory}/Server/lib/fmeutil/fmecore"

  File {
    ensure  => file,
    mode    => '0755',
    owner   => $fmeserver::user,
    group   => $fmeserver::group,
    require => Class['fmeserver::install'],
  }

  file { "${ld_library_path}/libsde.so" :
    source => "${path}/libsde.so",
  }

  file { "${ld_library_path}/libsg.so" :
    source => "${path}/libsg.so",
  }

  file { "${ld_library_path}/libpe.so" :
    source => "${path}/libpe.so",
  }
}
