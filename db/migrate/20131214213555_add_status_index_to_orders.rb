class AddStatusIndexToOrders < ActiveRecord::Migration
  def change
    add_index :orders, :status
  end
end
