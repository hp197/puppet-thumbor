# Class: thumbor
# ===========================
#
# This class will manage the thumbor installation
#
# Parameters
# ----------
#
# [*security_key*]
#   Optional[String]
#   Default: undef
#   The thumbor security key who is used to accept requests
#   If undef, security will be set to disabled.
#
# [*host*]
#   String
#   Default: 0.0.0.0
#   The ip to bind to
#
# [*port*]
#   Integer
#   Default: 3000
#   The port to listen on
#
# [*package_name*]
#   String
#   Default: thumbor
#   Package name, when installing thumbor.
#
# [*package_ensure*]
#   String
#   Default: present
#   Package version (or 'present', 'absent', 'latest'), when installing thumbor.
#
# [*proxy_server*]
#   Optional[String]
#   Default: false
#   Proxy server to use when installing from pip (or false to disable functionality)
#
# [*user*]
#   String
#   Default: thumbor
#   User to run thumbor as.
#
# [*group*]
#   String
#   Default: thumbor
#   Group to run thumbor as.
#
#
# Variables
# ----------
#
# Examples
# --------
#
# @example
#    class { 'thumbor':
#      security_key => '1234567890',
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class thumbor (
  Enum['present', 'absent', 'running']  $ensure           = $thumbor::params::ensure,
  Optional[String]                      $security_key     = $thumbor::params::security_key,
  String                                $host             = $thumbor::params::host,
  Integer                               $port             = $thumbor::params::port,
  Integer                               $processes        = $thumbor::params::processes,
  Optional[String]                      $virtualenv_path  = $thumbor::params::virtualenv_path,
  String                                $package_name     = $thumbor::params::package_name,
  String                                $package_ensure   = $thumbor::params::package_ensure,
  Optional[String]                      $proxy_server     = $thumbor::params::proxy_server,
  Boolean                               $ensure_user      = $thumbor::params::ensure_user,
  String                                $user             = $thumbor::params::user,
  Boolean                               $ensure_group     = $thumbor::params::ensure_group,
  String                                $group            = $thumbor::params::group,
  Hash                                  $raw_config,
) inherits thumbor::params
{
  $apppath = $virtualenv_path ? {
    undef   => '/usr/local/',
    default => "${virtualenv_path}/",
  }

  anchor { 'thumbor::begin': }
  -> class{ 'thumbor::install': }
  -> class{ 'thumbor::config': }
  -> class{ 'thumbor::service': }
  -> anchor { 'thumbor::end': }

}
