class UsersController < ApplicationController

  get '/users/:slug' do 

  end 

  get '/signup/?' do 
    if !logged_in?
      erb :'users/create'
    else
      erb :'items/index'
    end
  end

  post '/signup' do 

  end

  get '/login/?' do 

  end

  post '/login' do 

  end

  get '/logout/?' do 

  end
end