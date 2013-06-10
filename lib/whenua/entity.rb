require 'active_support'
require 'active_model'
require 'virtus'

module Whenua
  module Entity
    include Virtus
    extend ActiveSupport::Concern
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    included do
      attr_reader :id
    end

    # def initialize(args = {})
    #   method_strings = methods.map(&:to_s)
    #   args.each do |attribute, value|
    #     send("#{attribute}=", value) if method_strings.include?("#{attribute}=")
    #     instance_variable_set("@#{attribute}", value) if method_strings.include?(attribute.to_s)
    #   end
    # end

    def created_at
      Time.parse @created_at.to_s
    end

    def updated_at
      Time.parse @updated_at.to_s
    end

    def persisted?
      id.present?
    end

    def touch
      now = Time.now.utc
      @created_at = now if @created_at.nil?
      @updated_at = now
    end

    def type
      self.class.name.downcase
    end

    def ==(other)
      self.id == other.id
    end

  end
end
