require 'konfig/config_section'
require 'spec_helper'

RSpec.describe Konfig::ConfigSection do
  before :all do
    @section = Konfig::ConfigSection.new({ foo_key: 'foo' })
  end

  it 'should have the expected keys' do
    expect(@section.has?(:foo_key)).to eq true
  end

  it 'should not have unexpected keys' do
    expect(@section.has?(:bar_key)).to eq false
  end

  it 'should raise an exception when a nonexistent key is accessed' do
    expect { @section[:bar_key] }.to raise_error(KeyError)
  end
end
