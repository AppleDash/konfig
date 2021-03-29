require 'konfig'
require 'spec_helper'

class CustomConfig < Konfig::Config
  SECTIONS = [:foo, :bar]

  attr_accessor *SECTIONS

  def initialize
    super File.join(__dir__, 'configs'), SECTIONS
  end
end

RSpec.describe Konfig::Config do
  before :all do
    @config = CustomConfig.new
  end

  it 'should have the expected sections in the config hash' do
    expect(@config.config[:foo]).to_not be_nil
    expect(@config.config[:bar]).to_not be_nil
  end

  it 'should have the expected sections in attributes' do
    expect(@config.foo).to_not be_nil
    expect(@config.bar).to_not be_nil
  end

  it 'should have the correct values' do
    expect(@config.foo[:foo_key]).to eq 'foo value'
    expect(@config.bar[:bar_key]).to eq 'bar value'
  end

  it 'should have the correct values for local overrides' do
    expect(@config.foo[:foo_other_key]).to eq 'i have been overridden'
  end
end
