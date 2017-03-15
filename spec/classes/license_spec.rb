require 'spec_helper'

describe 'fmeserver::license' do
  let(:pre_condition) { 'include fmeserver' }

  let(:params) {{
    :license_server => 'example.com',
  }}

  it { is_expected.to contain_package('libgtkglext1') }
  it { is_expected.to contain_package('libjpeg62') }
  it { is_expected.to contain_file('/opt/safe/fmeserver.licserver') }
  it { is_expected.to contain_exec('license_fme') }

end
