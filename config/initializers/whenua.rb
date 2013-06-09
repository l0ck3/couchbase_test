Whenua.configure(:couchbase) do |config|
  config.bucket                = "alerti-test"
  config.environment           = Rails.env
  config.couchbase_config_file = Rails.root.join('config', 'couchbase.yml')
end
