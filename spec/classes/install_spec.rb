require 'spec_helper'

describe 'fmeserver::install' do
  let(:params) {{
    :install_source    => 'http://downloads.safe.com/fme/2015/fme-server-b15515-linux-x64.run',
    :home_directory    => '/opt/safe',
    :install_directory => '/opt/safe/fmeserver',
    :user              => 'fme',
    :admin_username    => 'admin',
    :admin_password    => 'password',
    :group             => 'fme',
    :hostname          => 'fme.example.com',
    :zip_version       => 'installed',
    :lsb_core_version  => 'installed',
  }}

  it { is_expected.to contain_file('/opt/safe') }
  it { is_expected.to contain_file('/opt/safe/fme-server.run') }
  it { is_expected.to contain_package('lsb-core') }
  it { is_expected.to contain_package('zip') }
  it { is_expected.to contain_file('/opt/safe/install.cfg') }
  it { is_expected.to contain_exec('install_fmeserver') }
  it { is_expected.to contain_file('/opt/safe/fmeserver/Server/fmeEngineConfig.txt') }
end