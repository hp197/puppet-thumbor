
class thumbor::params
(
  Enum['present', 'absent']     $ensure           = 'present',
  Optional[String]              $security_key     = undef,
  String                        $listen           = '127.0.0.1',
  Variant[Array[String],String] $ports            = [ '8000' ],
  Optional[String]              $virtualenv_path  = undef,
  String                        $package_name     = 'thumbor',
  String                        $package_ensure   = $ensure,
  Variant[Boolean, String]      $pip_proxyserver  = false,
  Boolean                       $ensure_user      = true,
  String                        $user             = 'thumbor',
  Boolean                       $ensure_group     = true,
  String                        $group            = 'thumbor',
  Hash                          $default_options  = {
    'allowed_sources' => ['.'],
  },
)
{
}