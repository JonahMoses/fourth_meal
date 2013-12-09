class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :purchase, :confirmation]

  def index
    @orders = current_user.orders.order("created_at DESC")
  end

  def show
  end

  def new
    @order = current_user.orders.new
  end

  def edit
  end

  def create
    @order = current_user.orders.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to items_path }
    end
  end

  def purchase
    if @order.purchaseable?
      @order.purchase!
      session[:order_id] = nil
      redirect_to confirmation_order_path(@order)
    elsif @order.user.guest
      redirect_to sign_up_path
    else
      redirect_to @order, notice: "That order is #{@order.status} and can't be purchased.  Please purchase your current cart."
    end
  end

  def guest_purchase
    @restaurants = Restaurant.all
  end

  def guest_confirm_purchase
    @restaurants = Restaurant.all
    if current_user.update_attributes(user_params) && current_user.validate_guest_order
      current_user.save
      current_order.update_attributes(status: "paid")
      order = current_order
      session[:order_id] = nil
      redirect_to confirmation_order_path(order)
    else
      render :guest_purchase
    end
  end

  def confirmation
    @restaurants = Restaurant.all
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
