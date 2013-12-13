class AddRegionIdIndexToRestaurants < ActiveRecord::Migration
  def change
    add_index :restaurants, :region_id
  end
end
