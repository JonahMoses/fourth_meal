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

  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
    },
    :default_url => "food_fight_logo.png",
    :url => "/assets/images/:id_logo.png",
    :path => ":rails_root/public/assets/images/:id_logo.png"

    validates_attachment_size :image, :less_than => 5.megabytes
    validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

    # process_in_background :image
  def self.form_statuses
    ["pending", "approved", "active", "inactive", "rejected"].freeze
  end

  def self.active
    where(:status => "active")
  end

  def self.rejected
    where(:status => 'rejected')
  end

  def self.admin_visible
    where("status NOT LIKE 'rejected'")
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

