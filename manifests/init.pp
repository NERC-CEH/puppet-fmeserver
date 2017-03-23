# == Class: fmeserver
#
# This is the fmeserver module. This class installs FME Server and manages the
# created services.
#
# This class optionally manages zip and lsb-core packages which are both
# required by fmeserver.
#
# === Parameters
#
# [*install_source*]    The location of the installation media obtainable via wget
#
class fmeserver (
  $install_source = undef,
) {

  include wget
  if $install_source {
    wget::fetch { $install_source :
      destination => '/tmp/fme-server.run',
    }
  }

  package { 'lsb-core' :
    ensure => present,
  }

  package { 'zip' :
    ensure => present,
  }
}
