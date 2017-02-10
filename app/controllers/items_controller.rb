class ItemsController < ApplicationController

  get '/items' do 
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @items = Item.all
      erb :'items/index'
    else
      redirect '/signup'
    end
  end

  get '/items/:id' do 
    if logged_in?
      @item = Item.find_by_id(params[:id])
      erb :'items/show'
    else
      redirect '/login'
    end
  end

end