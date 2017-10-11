
class thumbor::install
(
)
{
  $proxy = $thumbor::proxy_server ? {
    undef   => false,
    default => $thumbor::proxy_server,
  }

  class { 'python' :
    version    => 'system',
    pip        => 'present',
    dev        => 'present',
    virtualenv => 'present',
  }

  if $thumbor::virtualenv_path
  {
    # Install thumbor in a virtualenv.
    python::virtualenv { $thumbor::virtualenv_path:
      ensure  => $thumbor::package_ensure,
      version => 'system',
      proxy   => $proxy,
      owner   => $thumbor::user,
      group   => $thumbor::group,
      require => [ Class['python'] ]
    }
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
    require     => Package[['libcurl4-openssl-dev', 'build-essential', 'libssl-dev']],
  }

  ensure_packages(['libglib2.0-0', 'libsm6', 'libxrender1'])

  python::pip { 'opencv-python':
    ensure      => $thumbor::package_ensure,
    virtualenv  => $venv,
    proxy       => $proxy,
    require     => Package[['libglib2.0-0', 'libsm6', 'libxrender1']],
  }
}