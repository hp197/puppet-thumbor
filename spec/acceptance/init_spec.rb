require 'spec_helper'
describe 'thumbor', type: :class do
  context 'Minimal config test - Debian 9' do
    let (:params) {
      {
        :config => {}
      }
    }
    let(:facts) {
      debian_9_facts
    }

    it { is_expected.to create_class('thumbor') }
    it { is_expected.to contain_anchor('thumbor::begin') }
    it { is_expected.to contain_class('Thumbor::Params') }
    it { is_expected.to contain_class('Thumbor::Install') }
    it { is_expected.to contain_class('Thumbor::Config') }
    it { is_expected.to contain_class('Thumbor::Service') }
    it { is_expected.to contain_anchor('thumbor::end') }
  end
end
