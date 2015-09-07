class fmeserver (
  $install_source    = 'http://downloads.safe.com/fme/2015/fme-server-b15515-linux-x64.run',
  $home_directory    = '/opt/safe',
  $install_directory = '/opt/safe/fmeserver',
  $user              = 'fme',
  $group             = 'fme',
  $manage_user       = true,
  $manage_group      = true,
  $hostname          = $::fqdn,
) {

  if $manage_user {
    # Ensure the tomcat user is present and has a home
    user { $user :
      ensure => present,
      gid    => $group,
    }
  }

  if $manage_group {
    # Ensure the tomcat group is present
    group { $group :
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
