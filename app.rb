require 'sinatra'
require_relative 'data_mapper_setup'

class UsersApi < Sinatra::Base

  get "/" do
    redirect to"/users/new"
  end

  get "/users/new" do
    # User.new
    erb :'users/new'
  end

  post "/users/new" do
    User.create(username: params[:name])
    redirect to"/users"
  end

  get "/users" do
    @users = User.all
    erb :'users/index'
  end

  run! if app_file == $0

end
