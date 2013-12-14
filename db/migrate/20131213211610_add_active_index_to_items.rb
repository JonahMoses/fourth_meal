class AddActiveIndexToItems < ActiveRecord::Migration
  def change
    add_index :items, :active
  end
end
