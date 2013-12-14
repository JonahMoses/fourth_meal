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
    mail(to: @user.email, subject: "Thank you for your order!")
  end

  # def order_confirmation()
  #   @user = user_attributes
  #   @order = order_attributes
  #   @total = order_total
  #   @url2 = 'http://fourth-meal.herokuapp.com'
  #   mail(to: @user[:email],
  #         subject: 'Thank you for your order!')
  # end

  def new_restaurant_submission_confirmation(user, restaurant)
    @user = user
    @restaurant = restaurant
    @url2 = 'http://fourth-meal.herokuapp.com'
    mail(to: @user.email,
          subject: 'Thank you for submitting a New Restaurant to FoodFight')
  end
end
