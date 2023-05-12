# === Archieved ===

[puppet-thumbor](https://github.com/hp197/puppet-thumbor)
==============

#### Table of Contents

1. [Overview](#overview)
2. [Dependencies - Where this module depends on](#dependencies)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Puppet module to deploy and manage Thumbor http://github.com/globocom/thumbor.

## Dependencies

This module depends on: 

* [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib) for standard libraries.
* [stankevich/python](https://github.com/stankevich/puppet-python) for python virtualenv and pip installation.

## Usage

### Short demo

Install Thumbor in your environment:

```
class { 'thumbor':
  ports => [ '8000' ],
}
```

Next go on your favorite shell browser (like curl or wget) and open http://127.0.0.1:8000/unsafe/200x200/https://puppet.com/themes/hoverboard/images/puppet-logo/puppet-logo-amber-white-lg.png (as an example) from the same machine as to where you applied the puppet code.

### Classes and Defined Types

#### Class: Thumbor

Installs and manages Thumbor

** Parameters within `thumbor`

#### `ensure`

Enum['present', 'absent']
*Default: present*

Controls if everything will be installed or forcefully will be removed

#### `security_key`

Optional[String]
*Default: undef*

The security key to hash the requested url with in Thumbor.
Please see the documentation of Thumbor for more information about this topic.

#### `listen`

String
*Default: 127.0.0.1*

The ip address to listen on.

#### `ports`

Variant[Array[String],String]
*Default: [ '8000' ]*

The port(s) Thumbor listens on.
This settings also controls how many instances are spinned up.

#### `virtualenv_path`

Optional[String]
*Default: undef*

If this setting is undef we will not use virtualenv.
If set, we will use the path as base for a virtual environment.

#### `package_name`

String
*Default: thumbor*

Name of the pip package to install.

#### `package_ensure`

Enum['present', 'absent', 'latest']
*Default: [$ensure](#ensure)*

Controls what is ensured on the pip installation.
Can be set to latest, to force pip to always installs the latest available version.
But can also be set to a specifc version to force that version to be installed.

#### `pip_proxyserver`

Variant[Boolean, String]
*Default: false*

The full URL to the proxy server to use with the pip installation of packages.
Note that if you dont want to use a proxy, this should be set to false.

#### `ensure_user`

Boolean
*Default: true*

If we should manage the user from the thumbor code.

#### `user`

String
*Default: thumbor*

The user to run the thumbor process with.

#### `ensure_group`

Boolean
*Default: true*

If we should manage the user from the thumbor code.

#### `group`

String
*Default: thumbor*

The group to run the thumbor process with.

#### `config`

Hash
*Default: {'allowed_sources' => ['.']}*

The configuration for thumbor.
Note the hash keys will be converted to upper case.

You can refer to Thumbor wiki for configuration options https://github.com/globocom/thumbor/wiki/Configuration 

#### `additional_packages`

[Array]
*Default: A OS-specific list of packages*

Specifies a list of additional packages that are required for thumbor or any of it's dependencies.

## Reference

### Classes

#### Public Classes

* `thumbor`: Installs and manages Thumbor

#### Private Classes

* [`thumbor::config`]  Manages the configuration of the thumbor application
* [`thumbor::install`] Manages the installation of the thumbor packages
* [`thumbor::service`] Manages the installation of the thumbor services

## Limitations

This module is tested on the following platforms:

* Debian 9 (stretch)

It is tested with the OSS version of Puppet (>= 4.10.0) only.

## Development

### Contributing

Please read CONTRIBUTING.md for full details on contributing to this project.
