class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
  validates  :quantity, :numericality => { :greater_than => 0 }

  def subtotal
    quantity*item.price
  end

  def increment(additional = 1)
    self.quantity += additional
    self.save!
  end

  def active?
    item.active
  end

end
