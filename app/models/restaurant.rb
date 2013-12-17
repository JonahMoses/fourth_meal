class Restaurant < ActiveRecord::Base
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validate :title_not_forbidden

  FORBIDDEN_NAMES = %w[javascripts stylesheets images]

  has_many  :items
  has_many  :orders
  has_many  :jobs
  belongs_to :region

  after_create :set_defaults

  def self.active
    where(:status => "active")
  end

  def approve
    self.update(:status => "approved")
  end

  def activate
    self.update(:status => "active")
  end

  def reject
    self.update(:status => "rejected")
  end

  def set_defaults
    self.update(slug: title.parameterize)
  end

private

  def title_not_forbidden
    if self.title.in? FORBIDDEN_NAMES
      errors.add(:title, 'Pick another title')
    end
  end

end

