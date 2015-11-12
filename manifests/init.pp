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
# [*home_directory*]    A workspace directory for storing installation media
# [*install_directory*] The directory where fme should be installed to
# [*user*]              who will run fme server
# [*group*]             of the user who will run fme server
# [*uid*]               of the user who will run fme server
# [*gid*]               of the group who will run fme server
# [*manage_user*]       if this module should managed the fme user
# [*manage_group*]      if this module should managed the fme group
# [*hostname*]          where this fme server will be run from
# [*admin_username*]    the username used to login to fme server
# [*admin_password*]    the password used to login to fme server
# [*zip_version*]       the version of zip to install (false stosp install)
# [*lsb_core_version*]  the version of lsb-core to install (false stosp install)
# [*results_lifetime*]  the time in seconds Data Download Service files remain in DefaultResults directory
# [*purge_interval*]    the time interval in seconds that DefaultResults directory is checked for expired content
#
class fmeserver (
  $install_source    = 'http://downloads.safe.com/fme/2015/fme-server-b15515-linux-x64.run',
  $home_directory    = '/opt/safe',
  $install_directory = '/opt/safe/fmeserver',
  $user              = 'fme',
  $group             = 'fme',
  $uid               = undef,
  $gid               = undef,
  $manage_user       = true,
  $manage_group      = true,
  $hostname          = $::fqdn,
  $admin_username    = 'admin',
  $admin_password    = 'password',
  $zip_version       = installed,
  $lsb_core_version  = installed,
  $results_lifetime  = 2592000,
  $purge_interval    = 43200,
) {

  if $manage_user {
    # Ensure the fme user is present
    user { $user :
      uid    => $uid,
      ensure => present,
      gid    => $group,
    }
  }

  if $manage_group {
    # Ensure the fme group is present
    group { $group :
      gid    => $gid,
      ensure => present,
    }
  }

  include fmeserver::install

  fmeserver::service { 'FMEServerDatabaseStart' :
    start_priority => 98,
    stop_priority  => 99,
  }

  fmeserver::service { 'FMEServerSMTPRelayStart' :
    start_priority => 98,
    stop_priority  => 99,
  }

  fmeserver::service { 'FMEServerStart' :
    start_priority => 99,
    stop_priority  => 98,
  }

  fmeserver::service { 'FMEServerAppServerStart' :
    start_priority => 99,
    stop_priority  => 99,
  }

  fmeserver::service { 'FMEServerCleanupStart' :
    start_priority => 99,
    stop_priority  => 99,
  }

  fmeserver::service { 'FMEServerWebSocketStart' :
    start_priority => 99,
    stop_priority  => 99,
  }

  Class['fmeserver::install'] ->
    Fmeserver::Service <| start_priority == 98 |> ->
    Fmeserver::Service <| start_priority == 99 |>
}
