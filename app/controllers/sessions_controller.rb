class SessionsController < ApplicationController

  def new
    @restaurants = Restaurant.all
  end

  def create
    @restaurants = Restaurant.all
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      if current_order && user.has_unsubmitted_orders?
        unsubmitted_order_restaurant = @restaurants.select { |restaurant| restaurant.id == current_order.restaurant_id }.first
        redirect_to "/#{unsubmitted_order_restaurant.slug}/order/#{current_order.id}", notice: "redirected to unfinished order"
      else
        redirect_to root_path, notice: "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "Logged out!"
  end


end
