require 'sinatra'
require 'httparty'
require 'json'

class UserController < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  set :port, 9494

  get "/" do
    redirect to"/users"
  end

  get "/users" do
    response = HTTParty.get("http://localhost:4567/users")
    @users = JSON.parse(response)
    erb :index, :layout => :'templates/layout'
  end

  get "/users/new" do
    erb :"users/new", :layout => :'templates/layout'
  end

  post "/users/new" do
    HTTParty.post("http://localhost:4567/users/new", :query => params )
    redirect to"users"
  end

  get "/users/edit" do
    response = HTTParty.get("http://localhost:4567/users")
    @users = JSON.parse(response)
    erb :"users/edit", :layout => :'templates/layout'
  end

  post "/users/edit" do
    HTTParty.put("http://localhost:4567/users/#{params["user_id"]}", :query => params )
    redirect to"users/edit"
  end

  get "/users/delete" do
    response = HTTParty.get("http://localhost:4567/users")
    @users = JSON.parse(response)
    erb :"users/delete", :layout => :'templates/layout'
  end

  post "/users/delete" do
    HTTParty.post("http://localhost:4567/users/#{params["user_id"]}", :query => params )
    redirect to"users/delete"
  end

  run! if app_file == $0
end
