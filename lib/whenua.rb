require 'whenua/entity'
require 'whenua/repository'
require 'whenua/configuration'

module Whenua
  class << self
    attr_reader :config
  end

  def self.configure(data_store, &block)
    configuration_path = "whenua/#{data_store.to_s}/configuration"
    require configuration_path
    require "whenua/#{data_store}/data_store"
    @config = configuration_path.camelize.constantize.new
    yield(@config) if block_given?
  end

  def self.data_store
    @data_store ||= config.data_store
  end
end
