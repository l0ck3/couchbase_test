require 'couchbase'
require 'yaml'

module Whenua
  module Couchbase
    class DataStore
      def client
        return @client if @client

        if Whenua.config.client
          @client        = Whenua.config.client
          @bucket = Whenua.config.bucket
          return @client
        end

        config = YAML.load(File.read(Whenua.config.couchbase_config_file))[Whenua.config.environment]
        config = config.symbolize_keys

        host     = config.delete(:host)
        port     = config.delete(:port)
        password = ENV['COUCHBASE_PASSWORD'] || config.delete(:password)

        @bucket = config.delete(:bucket)

        @client      = ::Couchbase.new(
          hostname: host,
          port: port,
          bucket: @bucket,
          password: password
        )

        @client
      end

      def design_docs
        client.design_docs
      end

      def remove_all_documents
        _reset!
      end

      def save(options)
        key      = options.delete(:key)
        document = options[:value]

        if key.nil?
          key = _generate_id
          client.add(key, document)
        else
          client.replace(key, document)
        end

        key
      end

      def delete(key)
        client.delete(key)
      end

      def get(key)
        doc = {
          data: client.get(key),
          key: key
        }
      end

      private

      def _reset!
        @bucket.flush
      end

      def _generate_id
        SecureRandom.uuid
      end

    end
  end
end


