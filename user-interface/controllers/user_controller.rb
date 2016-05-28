require 'sinatra'
require 'rest-client'
require 'json'

class UserController < Sinatra::Base
  set :port, 9494
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }

  get "/" do
    redirect to"/users"
  end

  get "/users" do
    response = RestClient.get("localhost:4567/users")
    @users = JSON.parse(response)
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
