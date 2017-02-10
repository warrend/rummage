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

  get '/items/new' do 
    if !logged_in?
      redirect '/login'
    else
      @current_user = current_user
      @tags = Tag.all
      erb :'items/create'
    end
  end

  get '/items/:id' do 
    if logged_in?
      @user = current_user
      @item = Item.find_by_id(params[:id])
      erb :'items/show'
    else
      redirect '/login'
    end
  end

  post '/new' do 
    if !logged_in?
      redirect '/login'
    elsif params[:name] == '' || params[:description] == '' || params[:location] == ''
      redirect '/items/new'
    else
      @user = current_user
      @item = @user.new(name: params[:name], description: params[:description], location: [:location])
      
      @user.save

      redirect "/tweets/#{@tweet.id}"
    end
  end

end