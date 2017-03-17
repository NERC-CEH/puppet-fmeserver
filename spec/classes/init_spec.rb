require 'spec_helper'

describe 'fmeserver' do
  it { is_expected.to compile }
  it { is_expected.to contain_user('fme') }
  it { is_expected.to contain_group('fme') }
  it { is_expected.to contain_service('FMEServerAppServer') }
  it { is_expected.to contain_service('FMEServerCleanup') }
  it { is_expected.to contain_service('FMEServerCore') }
  it { is_expected.to contain_service('FMEServerDatabase') }
  it { is_expected.to contain_service('FMEServerEngines') }
  it { is_expected.to contain_service('FMEServerWebSocket') }
end