class thumbor::service
(
)
{
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  anchor { 'thumbor::service::begin': }
  -> file { '/etc/systemd/system/thumbor@.service':
    ensure  => $thumbor::ensure,
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0644',
    content => template('thumbor/thumbor.systemd.erb'),
    notify  => Exec['thumbor-systemd-reload'],
  }
  -> thumbor::service::systemd{ [ $thumbor::ports ]: }
  -> anchor { 'thumbor::service::end': }

  exec { 'thumbor-systemd-reload':
    command => 'systemctl daemon-reload',
    path    => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin' ],
  }
}

