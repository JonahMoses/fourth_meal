class GuestOrderMailerWorker
  include Sidekiq::Worker
  sidekiq_options queue: "guest_order_mailer"

  # def perform(order_id, user_id, user_full_name, order_user_email, order_total, order_status, order_created_at, order_order_items)
  #   UserMailer.order_confirmation(order_id, user_id, user_full_name, order_user_email, order_total, order_status, order_created_at, order_order_items).deliver
  # end

  def perform(order_attributes, user_attributes, order_total)
    UserMailer.order_confirmation(order_attributes, user_attributes, order_total).deliver
  end

end
