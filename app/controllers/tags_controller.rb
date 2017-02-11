class TagsController < ApplicationController
  
  get '/tags' do 
    if logged_in?
      @user = current_user
      @tags = Tag.all

      erb :'tags/index'
    else
      redirect '/login'
    end
  end

  get '/tags/:slug' do 
    if logged_in?
      @user = current_user
      @tag = Tag.find_by_slug(params[:slug])

      erb :'tags/show'
    else
      redirect '/login'
    end
  end

end