class Order < ActiveRecord::Base
  validates  :restaurant_id, presence: true

  scope :unsubmitted_orders, -> {where(status: 'unsubmitted')}

  has_many   :order_items, dependent: :destroy
  has_many   :items, through: :order_items
  belongs_to :user
  belongs_to :restaurant

  def total
    order_items.map(&:subtotal).reduce(:+)
  end

  def items_count
    order_items.map(&:quantity).reduce(:+)
  end

  def self.find_unsubmitted_order_for(user_id, restaurant_id)
    unsubmitted_orders.where(user_id: user_id, restaurant_id: restaurant_id).first
  end

  def purchaseable?
    status == "unsubmitted" && user && !user.guest
  end

  def purchase!
    return unless purchaseable?
    update_attributes(:status => "paid")
  end

end
