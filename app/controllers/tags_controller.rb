class TagsController < ApplicationController
  
  get '/tags' do 
    if logged_in?
      @user = current_user
      @tags = Tag.all
    else
      redirect '/login'
    end
  end

end