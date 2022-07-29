class UsersController < ApplicationController

  def show
    if current_user
      @user = current_user
      @items = UserFacade.user_items(session[:email])
      if @items 
        @recipes = RecipeFacade.find_recipes(@items)
      end
    else
      redirect_to '/'
      flash[:error] = "Please login to view your dashboard"
    end
  end

  def create
    auth_hash = request.env['omniauth.auth']
    session[:token] = auth_hash['credentials']['token']
    # session[:name] = auth_hash['info']['name']
    # session[:email] = auth_hash['info']['email']
    # user = current_user
    user = UserFacade.create_user(auth_hash)
    redirect_to '/dashboard'
  end
  
end