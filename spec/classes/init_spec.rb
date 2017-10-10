require 'spec_helper'
describe 'thumbor' do
  context 'with default values for all parameters' do
    it { should contain_class('thumbor') }
  end
end
