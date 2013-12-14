class UserMailerWorker
  include Sidekiq::Worker
  sidekiq_options queue: "user_mailer"

  def perform(user_email, user_name)
    UserMailer.welcome_email(user_email, user_name).deliver
  end

end
