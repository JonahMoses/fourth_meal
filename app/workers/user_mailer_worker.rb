class UserMailerWorker
  include Sidekiq::Worker

  def perform(user_email, user_name)
    UserMailer.welcome_email(user_email, user_name).deliver
  end

end
