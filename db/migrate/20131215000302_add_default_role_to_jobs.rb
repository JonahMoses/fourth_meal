class AddDefaultRoleToJobs < ActiveRecord::Migration
  def change
    change_column :jobs, :role, :string, :default => "Creator"
  end
end
