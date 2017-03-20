# == Class: fmeserver
#
# This is the fmeserver module. This class installs FME Server.
#
# === Parameters
#
# [*hostname*]          where this fme server will be run from
#
class fmeserver (
  $hostname = $::fqdn,
  $engines  = 2,
) {

  include ::docker
  
  file { '/fmeserverdata':
    ensure => directory,
  }

  file { '/tmp/docker-compose.yml':
    ensure => present,
    content => template('fmeserver/docker-compose.yml.erb'),
    scale   => {
      'fmeserverengine' => $engines,
    },
  }
}
