class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def new
    @user  = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailerWorker.perform_async(@user.email, @user.full_name)
      current_user.move_to(@user) if is_guest?
      session[:user_id] = @user.id
      redirect_to session[:last_order_page] || root_path, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      if @user.guest
        @user.update!(:guest => false) if @user.guest
        order = (current_order || user.unsubmitted_order)
        redirect_to restaurant_order_path(order.restaurant.slug, order), notice: "redirected to unfinished order"
      else
        redirect_to :back, notice: "Updated User"
      end
    else
      render 'new'
    end
  end

  def purchase
    if current_user == nil
      create_and_log_in_guest_user
    end
    @user = current_user
  end

  def show
  end

  def is_guest?
    current_user && current_user.guest?
  end

private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :email,
      :full_name,
      :display_name,
      :password,
      :password_confirmation,
      :credit_card_number,
      :billing_street,
      :billing_apt,
      :billing_city,
      :billing_state,
      :billing_zip_code,
      :shipping_street,
      :shipping_apt,
      :shipping_city,
      :shipping_state,
      :shipping_zip_code)
  end

end
