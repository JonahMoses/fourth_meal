class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :role
      t.integer :restaurant_id
      t.integer :user_id
    end
  end
end
