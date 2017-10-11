
class thumbor::params
(
  Optional[String] $security_key    = undef,
  String           $host            = '0.0.0.0',
  Integer          $port            = 3000,
  Optional[String] $virtualenv_path = undef,
  String           $package_name    = 'thumbor',
  String           $package_ensure  = 'present',
  Optional[String] $proxy_server    = undef,
  String           $user            = 'thumbor',
  String           $group           = 'thumbor',
  Array            $filters         = [],
  Array            $detectors       = [],
  Array            $allowed_sources = ['^.*$'],        
)
{
  $apppath = $virtualenv_path ? {
    undef   => '/usr/local/',
    default => "${virtualenv_path}/local",
  }
}