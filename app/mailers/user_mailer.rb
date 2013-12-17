class UserMailer < ActionMailer::Base
  default from: "foodfightinfo@gmail.com"

  def welcome_email(user_email, user_name)
    @user_email = user_email
    @user_name  = user_name
    @url = 'http://fourth-meal.herokuapp.com/log_in'
    @url2 = 'http://fourth-meal.herokuapp.com'
    mail(to: @user_email,
          subject: 'Welcome to Food Fight')
  end

  def order_confirmation(order_id)
    @order = Order.find(order_id)
    @user = @order.user
    @url2 = 'http://fourth-meal.herokuapp.com'
    mail(to: @user.email,
           subject: "Thank you for your order!")
  end

  def new_restaurant_submission_confirmation(user, restaurant)
    @user = user
    @restaurant = restaurant
    @url2 = 'http://fourth-meal.herokuapp.com'
    mail(to: @user.email,
          subject: 'Thank you for submitting a New Restaurant to FoodFight')
  end

  def new_restaurant_approval(user, restaurant)
    @user = user
    @restaurant = restaurant
    @url2 = 'http://fourth-meal.herokuapp.com'
    mail(to: @user.email,
          subject: "Your New Restaurant submission has been approved for FoodFight")
  end

  def new_restaurant_submission_notification(platform_admin, user, restaurant)
    @platform_admin = platform_admin
    @user = user
    @restaurant = restaurant
    @url2 = 'http://fourth-meal.herokuapp.com'
    mail(to: @platform_admin.email,
          subject: "A New Restaurant has been submitted to FoodFight")
  end
end
