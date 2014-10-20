require 'spec_helper'
describe 'gsdefaults' do

  context 'with defaults for all parameters' do
    it { should contain_class('gsdefaults') }
  end
end
