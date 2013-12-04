class Restaurant < ActiveRecord::Base
  validates                 :title, :description, presence: true
  validates                 :title, uniqueness: true

  def self.active
    where(:status => true)
  end

end
