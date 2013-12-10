class SessionsController < ApplicationController

  def new
    @restaurants = Restaurant.all
  end

  def create
    @restaurants = Restaurant.all
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      if user.orders.any? {|order| order.status == "unsubmitted"}
        unsubmitted_order_restaurant = @restaurants.select { |restaurant| restaurant.id == current_order.restaurant_id }
        redirect_to "/#{unsubmitted_order_restaurant.first.slug}/order/#{current_order.id}", :notice => "redirected to unfinished order"
      else
        redirect_to '/', :notice => "Logged in!"
      end
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
