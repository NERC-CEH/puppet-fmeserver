require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.default_facts = {
    :kernel => 'Linux',
    :operatingsystem => 'Ubuntu',
    :osfamily => 'Debian',
  }
end
