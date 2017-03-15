require 'spec_helper'

describe 'fmeserver::service' do
  let(:title) { 'FMEServerAppServerStart' }
  let(:params){{
    :start_priority    => 98,
    :stop_priority     => 99,
    :user              => 'fme',
    :install_directory => '/opt/safe/fmeserver',
  }}

  it { is_expected.to contain_file('/etc/init.d/FMEServerAppServerStart') }
  it { is_expected.to contain_file('/etc/rc2.d/S98FMEServerAppServerStart') }
  it { is_expected.to contain_file('/etc/rc6.d/K99FMEServerAppServerStart') }    
  it { is_expected.to contain_service('FMEServerAppServerStart')}

end