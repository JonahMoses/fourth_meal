class Restaurant < ActiveRecord::Base
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  has_many  :items
  has_many  :orders

  after_create :set_defaults

  def self.active
    where(:status => "active")
  end

  def approve
    self.update(:status => "approved")
  end

  def set_defaults
    self.update(slug: title.parameterize)
  end

end

