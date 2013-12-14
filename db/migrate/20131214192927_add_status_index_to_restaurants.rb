class AddStatusIndexToRestaurants < ActiveRecord::Migration
  def change
    add_index :restaurants, :status
  end
end
