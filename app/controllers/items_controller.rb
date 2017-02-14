require 'rack-flash'

class ItemsController < ApplicationController
  use Rack::Flash

  get '/items' do 
    if logged_in?
      @user = current_user
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
      if @item.user_id == current_user.id
        erb :'items/edit'
      else
        flash[:message] = "You can only edit your own posts!"
        redirect '/login'
      end
    end
  end

  post '/new' do 
    if !logged_in?
      redirect '/login'
    elsif params[:item][:name] == '' || params[:item][:description] == '' || params[:item][:location] == ''
      redirect '/items/new'
    else
      
      @user = current_user
      @item = Item.new(name: params[:item][:name], description: params[:item][:description], location: params[:item][:location])
      
      if @tag = Tag.find_by(name: params[:tag][:name])
        @item.tag = @tag 
      else
        @tag = Tag.new(name: params[:tag][:name].downcase)
        @item.tag = @tag
      end
      
      @tag.items << @item
      @user.items << @item
    
      @item.save

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
      flash[:message] = "You can only delete your own posts"
      redirect '/login'
    end
  end

end