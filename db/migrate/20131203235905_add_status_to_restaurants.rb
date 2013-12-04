class AddStatusToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :status, :boolean, default: true
  end
end
