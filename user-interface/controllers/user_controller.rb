require 'sinatra'
require 'httparty'
require 'json'

class UserController < Sinatra::Base
  set :port, 9494
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }

  before do
    p params
  end

  get "/" do
    redirect to"/users"
  end

  get "/users" do
    response = HTTParty.get("http://localhost:4567/users")
    @users = JSON.parse(response)
    erb :index
  end

  get "/users/new" do
    erb :"users/new"
  end

  post "/users/new" do
    HTTParty.post("http://localhost:4567/users/new", :query => params )
    redirect to"users"
  end

  get "/users/edit" do
    erb :"users/edit"
  end

  get "/users/delete" do
    response = HTTParty.get("http://localhost:4567/users")
    @users = JSON.parse(response)
    erb :"users/delete"
  end

  post "/users/delete" do
    HTTParty.post("http://localhost:4567/users/#{params["user_id"]}", :query => params )
    redirect to"users/delete"
  end

  run! if app_file == $0
end
