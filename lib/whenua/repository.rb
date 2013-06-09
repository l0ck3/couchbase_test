require 'active_support/inflector'
require 'active_support/core_ext/object/instance_variables'
require 'active_support/core_ext/hash/indifferent_access'
require 'json'

module Whenua
  module Repository
    extend ActiveSupport::Concern

    module ClassMethods
      # def all
      #   data_store.find_all(collection_name).map do |result|
      #     _deserialize(result[:key], result[:data])
      #   end
      # end

      # def collection(explicit_collection_name)
      #   @collection_name = explicit_collection_name
      # end

      # def collection_name
      #   @collection_name ||= default_collection_name
      # end

      # def default_collection_name
      #   ActiveSupport::Inflector.tableize(klass)
      # end

      def data_store
        @data_store ||= Whenua.data_store
      end

      def data_store=(store)
        @data_store = store
      end

      def delete(object)
        data_store.delete(object.id)
        nil
      end

      # def find_by_created_at(start_time, end_time)
      #   _find_by_attribute(:created_at, _format_time_for_index(start_time).._format_time_for_index(end_time))
      # end

      # def find_by_updated_at(start_time, end_time)
      #   _find_by_attribute(:updated_at, _format_time_for_index(start_time).._format_time_for_index(end_time))
      # end

      # def find_by_version(version)
      #   _find_by_attribute(:version, version)
      # end

      def find_by_id(id)
        if hash = data_store.get(id)
          _deserialize(hash[:key], hash[:data])
        end
      end

      def index(name, params={})
        _build_index_method(name, params)
      end

      def klass
        name.to_s.gsub("Repository", "").constantize
      end

      # def migrator
      #   @migrator ||= Whenua::Migrator.new(collection_name)
      # end

      def save(entity)
        entity.touch
        save_without_timestamps(entity)
      end

      def save_without_timestamps(entity)
        hash = {
          value:  _serialize(entity)
        }

        if entity.id
          hash[:key] = entity.id
          data_store.save(hash)
        else
          entity.instance_variable_set("@id", data_store.save(hash))
        end

        entity
      end

      def serialize(entity)
        HashWithIndifferentAccess.new(entity.instance_values)
      end

      # TODO : Cleanup this method
      def _build_index_method(index_name, params)
        metaclass = class << self; self; end
        metaclass.class_eval do
          define_method(index_name) do |*args|
            default_params = { limit: 100 }
            rows = data_store.design_docs[klass.to_s.downcase].send(index_name, default_params.merge(params)).fetch
            rows.map! do |row|
              if row.value.respond_to? :to_hash
                row = _deserialize(row.id, row.value)
              else
                row = row.value
              end
            end
          end
        end
      end

      # def _find_by_attribute(attribute, value)
      #   if results = data_store.find_by_attribute(collection_name, attribute, value)
      #     results.map do |hash|
      #       _deserialize(hash[:key], hash[:data])
      #     end
      #   end
      # end

      def deserialize(attributes)
        instance = klass.new(attributes)
        instance.instance_variable_set(:@id, attributes[:id])
        instance.instance_variable_set(:@created_at, attributes[:created_at])
        instance
      end

      def _deserialize(id, data)
        attributes      = data.with_indifferent_access
        attributes[:id] = id

        deserialize(attributes)
      end

      # def _format_time_for_index(time)
      #   time.to_json.gsub('"', '')
      # end

      # def _indexed_fields
      #   @indexed_fields || []
      # end

      # def _indexes(object)
      #   index_values = _indexed_fields.map { |field| [field, serialize(object)[field.to_sym]] }
      #   index_values += [
      #     [:created_at, _format_time_for_index(object.send(:created_at))],
      #     [:updated_at, _format_time_for_index(object.send(:updated_at))],
      #     [:version, object.version]
      #   ]
      #   Hash[index_values]
      # end

      def _serialize(entity)
        serialized_entity        = serialize(entity).reject { |key, val| val.nil? }
        serialized_entity[:type] = entity.type
        serialized_entity
      end

      # def _update_timestamps(entity)
      #   entity.updated_at = Time.now.utc
      #   entity.created_at ||= entity.updated_at
      # end
    end
  end
end
