class AddBillingShippingandCCinfotoUser < ActiveRecord::Migration
  def change
    add_column :users, :credit_card_number, :string, limit: 16
    add_column :users, :billing_address, :integer
    add_column :users, :shipping_address, :integer
    add_column :users, :billing_street, :string
    add_column :users, :shipping_street, :string
    add_column :users, :billing_apt, :string
    add_column :users, :shipping_apt, :string
    add_column :users, :billing_city, :string
    add_column :users, :shipping_city, :string
    add_column :users, :billing_state, :string
    add_column :users, :shipping_state, :string
    add_column :users, :billing_zip_code, :string, limit: 5
    add_column :users, :shipping_zip_code, :string, limit: 5
  end
end

