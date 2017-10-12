
class thumbor::config
(
)
{
  $_default_config = deep_merge($thumbor::raw_config, $thumbor::params::default_options)

  anchor { 'thumbor::config::begin': }
  -> file { "${thumbor::apppath}/thumbor.key":
    ensure  => $thumbor::package_ensure,
    content => $thumbor::security_key,
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0644',
  }
  -> file { "${thumbor::apppath}/thumbor.conf": 
    ensure  => $thumbor::package_ensure,
    content => template('thumbor/thumbor.conf.erb'),
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0644',
  }
  -> anchor { 'thumbor::config::end': }
}
