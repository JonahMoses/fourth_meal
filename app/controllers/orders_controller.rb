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
      format.html { redirect_to root_path, notice: 'Order has been deleted'}
    end
  end

  def purchase
    if @order.purchaseable?
      @order.purchase!
      UserMailer.order_confirmation(@current_user, @order).deliver
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
      GuestOrderMailerWorker.perform_async(current_order.attributes, current_user.attributes)
      session[:order_id] = nil
      redirect_to confirmation_order_path(order)
    else
      render :guest_purchase
    end
  end

  def confirmation
  end

private

  # require 'twilio-ruby'

  #   account_sid = "AC14a7433b640c35adf748c8e7fb2c7c1f"
  #   auth_token = "5d61bfcd8c12c9fe222f2a056871ac21"

  #   @client = Twilio::REST::Client.new account_sid, auth_token

  #   @message = @client.account.messages.create({:to => "+12316851234",
  #                                      :from => "+15555555555",
  #                                      :body => "Hello there!"})

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
