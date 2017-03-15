require 'spec_helper'

describe 'fmeserver' do
  it { is_expected.to compile }
  it { is_expected.to contain_user('fme') }
  it { is_expected.to contain_group('fme') }
  it { is_expected.to contain_service('FMEServerDatabaseStart') }
  it { is_expected.to contain_service('FMEServerSMTPRelayStart') }
  it { is_expected.to contain_service('FMEServerStart') }
  it { is_expected.to contain_service('FMEServerAppServerStart') }
  it { is_expected.to contain_service('FMEServerCleanupStart') }
  it { is_expected.to contain_service('FMEServerWebSocketStart') }
end