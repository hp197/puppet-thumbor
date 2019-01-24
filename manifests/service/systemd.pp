define thumbor::service::systemd
(
  String $port = String("${name}"),
)
{
  $service_name = "thumbor@${port}"

  service { $service_name:
    enable    => true,
    require   => Systemd::Unit_file['thumbor@.service'],
    subscribe => [ Class['systemd::systemctl::daemon_reload'], File["${thumbor::apppath}/thumbor.conf"] ],
  }

  exec { "start ${service_name}":
    command     => "systemctl start ${service_name}",
    refreshonly => true,
    subscribe   => Service[$service_name],
  }
}

