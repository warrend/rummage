require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

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
    elsif User.find_by(username: params[:username]) || User.find_by(email: params[:email])
      flash[:message] = "This username and/or password already exists!"
      redirect '/signup'
    else
      @user = User.create(username: params[:username].downcase, email: params[:email], password: params[:password])
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
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/items'
    else
      flash[:message] = "The email or password is incorrect!"
      redirect '/login'
    end
  end

  get '/logout' do 
    if logged_in?
      session.clear

      redirect '/login'
    else
      redirect '/login'
    end
  end
end