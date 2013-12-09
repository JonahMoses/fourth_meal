class SessionsController < ApplicationController

  def new
    @restaurants = Restaurant.all
  end

  def create
    @restaurants = Restaurant.all
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to '/', :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    reset_session
    redirect_to '/', :notice => "Logged out!"
  end


end
