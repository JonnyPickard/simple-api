require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'models/user'


DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/sinatra_api_test")


DataMapper.finalize
# DataMapper.auto_migrate!
DataMapper.auto_upgrade!
