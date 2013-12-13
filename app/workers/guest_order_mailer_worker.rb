class GuestOrderMailerWorker
  include Sidekiq::Worker
  sidekiq_options queue: "guest_order_mailer"

  # def perform(order_attributes, user_attributes, order_total)
  #   UserMailer.order_confirmation(order_attributes, user_attributes, order_total).deliver
  # end

  def perform(order_id)
    UserMailer.order_confirmation(order_id).deliver
  end

end
