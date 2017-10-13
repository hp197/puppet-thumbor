define thumbor::service::systemd
(
  $port = $name,
)
{
  exec { "thumbor-systemd-port-${port}":
    command => "systemctl enable thumbor@${port}",
    creates => "/etc/systemd/system/multi-user.target.wants/thumbor@${port}.service",
    path    => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin' ],
    notify  => Exec['thumbor-systemd-reload'],
  }

  service { "thumbor@${port}":
    enable   => true,
    provider => 'systemd',
  }
}

