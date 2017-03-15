require 'spec_helper'

describe 'fmeserver::arcsde' do
  let(:pre_condition) { 'include fmeserver' }
  let(:params) {{
    :path    => 'puppet:///esri/arcsde/sdk_100',
  }}

  it { is_expected.to contain_file('/opt/safe/fmeserver/Server/lib/fmeutil/fmecore/libsde.so') }
  it { is_expected.to contain_file('/opt/safe/fmeserver/Server/lib/fmeutil/fmecore/libsg.so') }
  it { is_expected.to contain_file('/opt/safe/fmeserver/Server/lib/fmeutil/fmecore/libpe.so') }

end