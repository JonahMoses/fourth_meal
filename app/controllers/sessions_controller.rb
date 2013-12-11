class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      if current_order || user.has_unsubmitted_orders?
        order = (current_order || user.unsubmitted_order)
        order.update(:user_id => user.id)
        session[:order_id] = order.id
        redirect_to restaurant_order_path(order.restaurant.slug, order), notice: "redirected to unfinished order"
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
