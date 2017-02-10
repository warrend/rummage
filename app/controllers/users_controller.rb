class UsersController < ApplicationController

  get '/users/:slug' do 
    if logged_in? && @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    else
      redirect '/login'
    end
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
    if params[:email] == '' || params[:password] == ''
      redirect '/login'
    else
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(password: params[:password])
        session[:user_id] = @user.id
        redirect '/items'
      end
    else
      redirect '/login'
    end
  end

  get '/logout' do 
    if logged_in?
      session.clear
    else
      redirect '/login'
    end
  end
end