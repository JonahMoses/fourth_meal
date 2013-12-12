class UserMailer < ActionMailer::Base
  default from: "foodfightinfo@gmail.com"

  def welcome_email(user)
    @user = user
    @url = 'http://fourth-meal.herokuapp.com/log_in'
    @url2 = 'http://fourth-meal.herokuapp.com'
    mail(to: @user.email,
          subject: 'Welcome to Food Fight')
  end

  def order_confirmation(current_user, order)
    @user = current_user
    @order = order
    @url2 = 'http://fourth-meal.herokuapp.com'
    mail(to: @user.email,
          subject: 'Thank you for your order!')
  end

  def new_restaurant_submission_confirmation(user, restaurant)
    @user = user
    @restaurant = restaurant
    @url2 = 'http://fourth-meal.herokuapp.com'
    mail(to: @user.email,
          subject: 'Thank you for submitting a New Restaurant to FoodFight')
  end
end
