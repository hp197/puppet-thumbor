class thumbor::service
(
)
{
  file { '/etc/systemd/user/thumbor@.service':
    ensure  => 'present',
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0644',
    content => template('thumbor/thumbor.systemd.erb')
    #notify  => Service['thumbor'],
  }

#  service { 'thumbor':
#    require => File[ '/etc/default/thumbor.conf' ]
#    ensure  => $thumbor::ensure,
#  }
}