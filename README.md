Simple API
============
A simple API demo with separate front and back ends. Made in `Ruby` using `Sinatra`, `HTTParty` and `DataMapper`.

The current version on heroku: http://jonnys-simple-api.herokuapp.com

Pictures
--------

### Home
<img src="https://github.com/JonnyPickard/screenshots/blob/master/screenshots/simple-api/home.png/">

### Create
<img src="https://github.com/JonnyPickard/screenshots/blob/master/screenshots/simple-api/create.png"/>

### Edit
<img src="https://github.com/JonnyPickard/screenshots/blob/master/screenshots/simple-api/edit.png"/>

### Delete
<img src="https://github.com/JonnyPickard/screenshots/blob/master/screenshots/simple-api/delete.png"/>

### Mobile Version
<img src="https://github.com/JonnyPickard/screenshots/blob/master/screenshots/simple-api/mobile-version.png"/>

Server Controller
----------------

```
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
```

User Interface Controller
------------------------

```
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

```

To Install
----------

- Clone this repository.
- Install Ruby version 2.3.0.
- Run `bundle install` in the root directory to install the gems.
- Run `ruby server.rb` in the server directory to run the API server.
- Run `ruby controllers/user_controller.rb` in the user-interface directory to run the user interface server.
- Go to http://localhost:9494 in browser.
- Enjoy!

About
-----

- Stores a list of usernames and ID's using a `DataMapper` and `Postresql` on the back end.
- The back end hosts an API containing usernames and user ID's.
- The front end contains forms for CRUD interactions via the back end API.
- Styling is done with `Bootstrap` and `CSS`.

Next Version
------------

- Add testing with either `RSpec` or `Rack::Test`
- Add encrypted token based authentication when accessing the API.
