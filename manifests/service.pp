class thumbor::service
(
)
{
  anchor { 'thumbor::service::begin': }
  -> file { '/etc/systemd/system/thumbor@.service':
    ensure  => 'present',
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0644',
    content => template('thumbor/thumbor.systemd.erb')
  }
  -> thumbor::service::systemd{ $thumbor::ports: }
  -> anchor { 'thumbor::service::end': }
}

define thumbor::service::systemd
(
  $port => $name,
)
{
  exec { "thumbor-systemd-port-${port}":
    command => "systemctl enable thumbor@${port}",
    creates => "/etc/systemd/system/multi-user.target.wants/thumbor@${port}.service",
    path    => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin' ],
  }

  service { "thumbor@${port}":
    enable    => true,
    provider  => 'systemd',
  }
}
