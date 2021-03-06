require 'sinatra'
require_relative 'data_mapper_setup'
require 'json'

class UsersApi < Sinatra::Base
  use Rack::MethodOverride

  get "/users" do
    User.all.to_json
  end

  post "/users/new" do
    @user = User.new(username: params[:name])

    if @user.save
      @user.to_json
    else
      halt 500
    end
  end

  get '/users/:id' do
    @user = User.get(params[:user_id])

    if @user
      @user.to_json
    else
      halt 404
    end
  end

  put '/users/:id' do
    @user = User.get(params[:user_id])
    @user.update(username: params[:name])

    if @user.save
      @user.to_json
    else
      halt 500
    end
  end

  post "/users/:id" do
    @user = User.get(params[:user_id])


    if @user.destroy
      {:success => "ok"}.to_json
    else
      halt 500
    end
  end

  run! if app_file == $0
end
