
class thumbor::params
(

  String            $ensure           = 'present',
  Optional[String]  $security_key     = undef,
  String            $host             = '0.0.0.0',
  Array[Integer]    $ports            = [ 8000 ],
  Optional[String]  $virtualenv_path  = undef,
  String            $package_name     = 'thumbor',
  String            $package_ensure   = 'present',
  Optional[String]  $proxy_server     = undef,
  Boolean           $ensure_user      = true,
  String            $user             = 'thumbor',
  Boolean           $ensure_group     = true,
  String            $group            = 'thumbor',
  Hash              $default_options  = {
    'allowed_sources' => ['^.*$'],
  },
)
{
}