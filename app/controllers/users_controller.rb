class UsersController < ApplicationController

  get '/users/:slug' do 

  end 

  get '/signup' do 
    if !logged_in?
      erb :'users/create'
    else
      erb :'items/index'
    end
  end

  post '/signup' do 
    if params[:username] == '' || params[:email] == '' || params[:password] == ''
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/items'
    end
  end

  get '/login' do 
    if !logged_in?
      erb :'users/login'
    else
      redirect :'/items'
    end
  end

  post '/login' do 

  end

  get '/logout' do 

  end
end