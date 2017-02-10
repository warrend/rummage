class ItemsController < ApplicationController

  get '/items' do 
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'items/index'
    else
      redirect '/signup'
    end
  end
end