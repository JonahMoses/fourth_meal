class OrdersController < ApplicationController
  before_action :set_order, only: [ :edit, :update, :destroy, :purchase, :confirmation]

  def index
    @orders = current_user.orders.order("created_at DESC")
  end

  def show
    @order = current_restaurant.orders.find_unsubmitted_order_for(@current_user, current_restaurant.id)
    # @order = current_order
    if current_order.order_items.empty?
      redirect_to "/#{current_restaurant.slug}"
    end
  end

  def new
    @order = current_user.orders.new
  end

  def edit
  end

  def create
    @order = current_user.orders.new(order_params)
      if @order.save
        redirect_to @order, notice: 'Order was successfully created.'
      else
        render action: 'new'
      end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @order.destroy
      redirect_to :back, notice: 'Order has been deleted'
  end

  def purchase
    if @order.purchaseable?
      @order.purchase!
      UserMailer.order_confirmation(@order.id).deliver
      session[:order_id] = nil
      redirect_to confirmation_order_path(@order)
    elsif @order.user.guest
      redirect_to purchase_users_path
    else
      redirect_to @order, notice: "That order is #{@order.status} and can't be purchased.  Please purchase your current cart."
    end
  end

  def guest_purchase
  end

  def guest_confirm_purchase
    if current_user.update_attributes(user_params) && current_user.validate_guest_order
      current_user.save
      current_order.update_attributes(status: "paid")
      order = current_order
      GuestOrderMailerWorker.perform_async(order.id)
      session[:order_id] = nil
      current_user.update(email: "")
      redirect_to confirmation_order_path(order)
    else
      render :guest_purchase
    end
  end

  def confirmation
  end

private

  def set_order
    if current_user.admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  def order_params
    params.require(:order).permit(:user_id, :status, :restaurant_id)
  end

  def user_params
    params.require(:user).permit(
                          :email,
                          :full_name,
                          :credit_card_number,
                          :billing_street,
                          :billing_city,
                          :billing_apt,
                          :billing_state,
                          :billing_zip_code,
                          :shipping_street,
                          :shipping_city,
                          :shipping_apt,
                          :shipping_state,
                          :shipping_zip_code)
  end

end
