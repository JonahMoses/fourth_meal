class AddRegionIdToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :region_id, :integer
  end
end
