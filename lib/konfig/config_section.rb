# frozen_string_literal: true
module Konfig
  class ConfigSection
    def initialize(config, local_config = {})
      @config = config.merge(local_config)
    end

    def has?(key)
      !@config[key].nil?
    end

    def [](key)
      raise KeyError, "#{key} not found" unless has? key

      @config[key]
    end
  end
end
