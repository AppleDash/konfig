# frozen_string_literal: true
require 'yaml'
require 'ostruct'
require_relative 'config_section'

module Konfig
  class Config
    attr_reader :config

    def initialize(root, categories)
      @config = OpenStruct.new
      config_files = Dir[File.join(root, '*.yml')]

      # Make sure everything expected is there...
      config_categories = config_files.map { |filename| File.basename(filename, '.yml').to_sym }
      missing_categories = (categories - config_categories)
      raise "Missing config categories: #{missing_categories}" if missing_categories.any?

      # ...and anything unexpected is not.
      extra_categories = (config_categories - categories)
      raise "Unexpected extra config files for categories: #{extra_categories}" if extra_categories.any?

      config_files.each do |filename|
        basename   = File.basename(filename, '.yml')
        local_file = File.join(root, 'local', "#{basename}.yml")
        local      = File.exists?(local_file) ? YAML.load_file(local_file) : {}
        parsed     = ConfigSection.new(YAML.load_file(filename), local)

        @config[basename] = parsed

        self.send("#{basename}=", parsed) # trust me, I'm a doctor
      end
    end
  end
end
