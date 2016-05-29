require 'sinatra'
require 'httparty'
require 'json'

class UserController < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')

  get "/" do
    redirect to"/users"
  end

  get "/users" do
    response = HTTParty.get("http://jonny-simple-api-server.herokuapp.com/users")
    @users = JSON.parse(response)
    erb :index, :layout => :'templates/layout'
  end

  get "/users/new" do
    erb :"users/new", :layout => :'templates/layout'
  end

  post "/users/new" do
    HTTParty.post("http://jonny-simple-api-server.herokuapp.com/users/new", :query => params )
    redirect to"users"
  end

  get "/users/edit" do
    response = HTTParty.get("http://jonny-simple-api-server.herokuapp.com/users")
    @users = JSON.parse(response)
    erb :"users/edit", :layout => :'templates/layout'
  end

  post "/users/edit" do
    HTTParty.put("http://jonny-simple-api-server.herokuapp.com/users/#{params["user_id"]}", :query => params )
    redirect to"users/edit"
  end

  get "/users/delete" do
    response = HTTParty.get("http://jonny-simple-api-server.herokuapp.com/users")
    @users = JSON.parse(response)
    erb :"users/delete", :layout => :'templates/layout'
  end

  post "/users/delete" do
    HTTParty.post("http://jonny-simple-api-server.herokuapp.com/users/#{params["user_id"]}", :query => params )
    redirect to"users/delete"
  end

  run! if app_file == $0
end
