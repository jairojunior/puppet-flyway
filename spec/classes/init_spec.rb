require 'spec_helper'
describe 'flyway' do

  context 'with defaults for all parameters' do
    it { should contain_class('flyway') }
  end
end
