module Whenua::Couchbase
  class Configuration
    include Whenua::Configuration

    attr_accessor :bucket, :couchbase_config_file

    def data_store
      Whenua::Couchbase::DataStore.new
    end
  end
end
