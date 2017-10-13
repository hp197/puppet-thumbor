
class thumbor::install
(
)
{
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  anchor { 'thumbor::install::begin': }

  if $thumbor::ensure_group {
    group { $thumbor::group:
      system  => true,
      ensure  => present,
      require => Anchor['thumbor::install::begin'],
      before  => Python::Virtualenv[$thumbor::virtualenv_path],
    }
  }

  if $thumbor::ensure_user {
    $homepath = $thumbor::virtualenv_path ? {
      undef   => '/home/thumbor/',
      default => "${thumbor::virtualenv_path}/",
    }

    user { $thumbor::user:
      system  => true,
      gid     => $thumbor::group,
      home    => $homepath,
      require => Group[$thumbor::group],
      before  => Python::Virtualenv[$thumbor::virtualenv_path],
    }
  }

  class { 'python' :
    version     => 'system',
    pip         => 'present',
    dev         => 'present',
    virtualenv  => 'present',
    require     => Anchor['thumbor::install::begin'],
  }

  if $thumbor::virtualenv_path {
    # Install thumbor in a virtualenv.
    python::virtualenv { $thumbor::virtualenv_path:
      ensure  => $thumbor::ensure,
      version => 'system',
      proxy   => $proxy,
      owner   => $thumbor::user,
      group   => $thumbor::group,
      require => [ Class['python'] ],
      before  => Anchor['thumbor::install::virtualenv'],
    }
  }
  anchor { 'thumbor::install::virtualenv': 
    require => Anchor['thumbor::install::begin'],
    before  => Anchor['thumbor::install::end'],
  }

  ensure_packages(['libcurl4-openssl-dev', 'build-essential', 'libssl-dev'])

  $venv = $thumbor::virtualenv_path ? {
    undef   => 'system',
    default => $thumbor::virtualenv_path,
  }

  python::pip { $thumbor::package_name:
    ensure      => $thumbor::package_ensure,
    virtualenv  => $venv,
    proxy       => $proxy,
    require     => [ Package[['libcurl4-openssl-dev', 'build-essential', 'libssl-dev']], Anchor['thumbor::install::virtualenv'] ],
    before      => Anchor['thumbor::install::end'],
  }

  ensure_packages(['libglib2.0-0', 'libsm6', 'libxrender1', 'libxext6'])

  python::pip { 'opencv-python':
    ensure      => $thumbor::package_ensure,
    virtualenv  => $venv,
    proxy       => $proxy,
    require     => [ Package[['libglib2.0-0', 'libsm6', 'libxrender1', 'libxext6']], Anchor['thumbor::install::virtualenv'] ],
    before      => Anchor['thumbor::install::end'],
  }

  anchor { 'thumbor::install::end': }
}