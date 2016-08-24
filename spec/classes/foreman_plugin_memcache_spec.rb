require 'spec_helper'

describe 'foreman::plugin::memcache' do
  let(:facts) do
    on_supported_os['redhat-7-x86_64']
  end

  let(:pre_condition) { 'include foreman' }

  it 'should call the plugin' do
    should contain_foreman__plugin('memcache')
  end
end
