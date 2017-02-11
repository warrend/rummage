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
      if @item = Item.find_by_id(params[:id])
        erb :'items/show'
      else
        redirect '/items'
      end
    else
      redirect '/login'
    end
  end

  get '/items/:id/edit' do 
    if logged_in? 
      @item = Item.find_by_id(params[:id])
      erb :'items/edit'
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
      @item = @user.items.build(name: params[:name], description: params[:description], location: params[:location])
      if tag = Tag.find_by(name: params[:tag])
        @item.tag = tag 
      else
        tag = Tag.new(name: params[:tag].downcase)
        @item.tag = tag
      end
      @item.save
      @user.save

      redirect "/items/#{@item.id}"
    end
  end

  patch '/items/:id' do 
    @item = Item.find_by_id(params[:id])
    @item.name = params[:name]
    @item.description = params[:description]
    @item.location = params[:location]
    if tag = Tag.find_by(name: params[:tag])
      @item.tag = tag 
    else
      tag = Tag.new(name: params[:tag])
      @item.tag = tag
    end
    @item.save

    redirect "/items/#{@item.id}"
  end

  delete '/items/:id/delete' do 
    if logged_in?
      @item = Item.find_by_id(params[:id])
      @item.delete

      redirect '/items'
    else
      redirect '/login'
    end
  end




end