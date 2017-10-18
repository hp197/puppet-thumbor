define thumbor::service::systemd
(
  $port = $name,
)
{
  exec { "thumbor-systemd-enable-port-${port}":
    command => "systemctl enable thumbor@${port}",
    creates => "/etc/systemd/system/multi-user.target.wants/thumbor@${port}.service",
    path    => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin' ],
    notify  => Exec['thumbor-systemd-reload'],
  }

  exec { "thumbor-systemd-start-port-${port}":
    command => "systemctl start thumbor@${port}",
    path    => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin' ],
    unless  => "systemctl status thumbor@${port}"
    notify  => Exec['thumbor-systemd-reload'],
    require => Exec["thumbor-systemd-enable-port-${port}"],
  }

  service { "thumbor@${port}":
    enable   => true,
    provider => 'systemd',
    require  => Exec["thumbor-systemd-enable-port-${port}"],
  }
}

