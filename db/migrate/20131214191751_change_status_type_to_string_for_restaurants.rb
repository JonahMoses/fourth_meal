class ChangeStatusTypeToStringForRestaurants < ActiveRecord::Migration
  def change
    change_column :restaurants, :status, :string, :default=>"pending"
  end
end
