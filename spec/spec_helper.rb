require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet/indirector/catalog/compiler'
require 'rspec-puppet-facts'

include RspecPuppetFacts

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

# Magic to add a catalog.exported_resources accessor
class Puppet::Resource::Catalog::Compiler
  alias_method :filter_exclude_exported_resources, :filter
  def filter(catalog)
    filter_exclude_exported_resources(catalog).tap do |filtered|
      # Every time we filter a catalog, add a .exported_resources to it.
      filtered.define_singleton_method(:exported_resources) do
        # The block passed to filter returns `false` if it wants to keep a resource. Go figure.
        catalog.filter { |r| !r.exported? }
      end
    end
  end
end

module Support
  module ExportedResources
    # Get exported resources as a catalog. Compatible with all catalog matchers, e.g.
    # `expect(exported_resources).to contain_myexportedresource('name').with_param('value')`
    def exported_resources
      # Catalog matchers expect something that can receive .call
      proc { subject.call.exported_resources }
    end
  end
end

def get_spec_fixtures_dir
  spec_dir = File.expand_path(File.dirname(__FILE__) + '/fixtures')
  raise "The directory #{spec_dir} does not exist" unless Dir.exists? spec_dir
  spec_dir
end

def read_fixture_file filename
  filename = get_spec_fixtures_dir + "/#{filename}"
  raise "The fixture file #{filename} doesn't exist" unless File.exists? filename
  File.read(filename)
end

def centos_facts
  {
    :operatingsystem => 'CentOS',
    :osfamily        => 'RedHat',
    :kernel          => 'Linux',
  }
end

def debian_8_facts
  {
    :operatingsystem           => 'Debian',
    :osfamily                  => 'Debian',
    :operatingsystemmajrelease => '8',
    :kernel                    => 'Linux',
  }
end

def debian_9_facts
  {
    :operatingsystem           => 'Debian',
    :osfamily                  => 'Debian',
    :operatingsystemmajrelease => '9',
    :kernel                    => 'Linux',
  }
end

def centos_6_facts
  {
    :operatingsystem           => 'CentOS',
    :osfamily                  => 'RedHat',
    :operatingsystemmajrelease => '6',
    :kernel                    => 'Linux',
  }
end

def centos_7_facts
  {
    :operatingsystem           => 'CentOS',
    :osfamily                  => 'RedHat',
    :operatingsystemmajrelease => '7',
    :kernel                    => 'Linux',
  }
end

def ubuntu_1404_facts
  {
    :operatingsystem           => 'Ubuntu',
    :osfamily                  => 'Debian',
    :operatingsystemmajrelease => '14.04',
    :kernel                    => 'Linux',
  }
end

def ubuntu_1604_facts
  {
    :operatingsystem           => 'Ubuntu',
    :osfamily                  => 'Debian',
    :operatingsystemmajrelease => '16.04',
    :kernel                    => 'Linux',
  }
end

def archlinux_facts
  {
    :operatingsystem => 'Archlinux',
    :osfamily        => 'Archlinux',
    :kernel          => 'Linux',
  }
end

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
end

# put local configuration and setup into spec_helper_local
begin
  require 'spec_helper_local'
rescue LoadError
end

at_exit { RSpec::Puppet::Coverage.report! }

