class GuestOrderMailerWorker
  include Sidekiq::Worker

  def perform(order_id, user_id, user_full_name, order_user_email, order_total, order_status, order_created_at, order_order_items)
    UserMailer.order_confirmation(order_id, user_id, user_full_name, order_user_email, order_total, order_status, order_created_at, order_order_items).deliver
  end

end
