class ChangeJobToJobIdOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :job, :job_id 
  end
end
