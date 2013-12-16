class RestaurantsController < ApplicationController
  before_action :create_and_log_in_guest_user, only: [:show]

  def index
    @restaurants = Restaurant.where(:status => "active")
    @current_user = current_user
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @user = current_user
    @restaurant.creator_id = @user.id
    respond_to do |format|
      if @restaurant.save
        create_job(@user.id, @restaurant.id)
        UserMailer.new_restaurant_submission_confirmation(@user, @restaurant).deliver
        format.html { redirect_to '/', notice: 'Restaurant is submitted and pending approval' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def create_job(user_id, restaurant_id)
    Job.create(user_id: user_id, restaurant_id: restaurant_id)
  end

  def new
    @restaurant = Restaurant.new
  end

  def show
    @current_order = current_restaurant.orders.find_unsubmitted_order_for(@current_user, current_restaurant.id)
    @current_restaurant = current_restaurant
  end

  def details

  end

  def admin_restaurants
    @restaurants = current_user.my_restaurants
  end

  def approve
    @user = User.where(id: current_restaurant.creator_id).first
    current_restaurant.approve
    # Locate the creator_id
    # locate user_id from creator_id
    # Locate the jobs table row that has the
      # user_id & restuarant_id
    # change role from default "default role"
      # to "Admin"
    pending_restaurant_job.update(role: "Admin")
    UserMailer.new_restaurant_approval(@user, @restaurant).deliver
    redirect_to '/dashboard'
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:title, :description, :id, :status)
  end

  def pending_restaurant_job
    creator_id = current_restaurant.creator_id
    current_restaurant.jobs.first
  end

end
