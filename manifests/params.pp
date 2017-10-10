
class thumbor::params
(
  # this is all only tested on Debian
  # params gets included everywhere so we can do the validation here
  unless $facts['os']['family'] =~ /(Debian)/ {
    warning("${facts['os']['family']} is not supported for now")
  }

  Optional[String]  $security_key 	 = undef,
  String						$host						 = '0.0.0.0',
  Integer						$port						 = 3000,
  String						$package_name		 = 'thumbor',
  String						$package_ensure	 = 'present',
  Optional[String]	$proxy_server		 = undef,
  String						$user						 = 'thumbor',
  String						$group					 = 'thumbor',
  Array 						$filters				 = [],
  Array 						$detectors			 = [],
  Array 					  $allowed_sources = ['^.*$'],        
)
{
	
}