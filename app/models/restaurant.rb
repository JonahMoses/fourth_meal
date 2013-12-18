
class Restaurant < ActiveRecord::Base
  validates :title, :description, presence: true
  validates :title, uniqueness: true
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

  def self.active
    where(:status => "active")
  end

  def self.rejected
    where(:status => 'rejected')
  end

  def self.admin_visible
    where("status IS NOT 'rejected'")
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

end

