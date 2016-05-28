require_relative "../sinatra_config"

class UserController < Sinatra::Base
  set :port, 9494

  get "/users" do
    erb :index
  end

  get "/users/new" do
    erb :"users/new"
  end

  get "/users/edit" do
    erb :"users/edit"
  end

  get "/users/delete" do
    erb :"users/delete"
  end

  run! if app_file == $0
end
