class UserMailer < ActionMailer::Base
  default from: "foodfightinfo@gmail.com"

  def welcome_email(user)
    @user = user
    @url = 'http://fourth_meal.herokuapp.com/log_in'
    mail({to: @user.email,
          subject: 'Welcome to Food Fight'})
  end

  def order_confirmation(current_user, order)
    @user = current_user
    @order = order
    mail({to: @user.email,
         subject: 'Thank you for your order!'})
  end

end
