class User < ActiveRecord::Base
  attr_accessor :password
  has_many :orders
  has_one :job
  before_validation :downcase_email

  before_save   :encrypt_password
  with_options :unless => :guest? do |user|
    user.validates_confirmation_of :password
    user.validates_presence_of     :password, :on => :create
    user.validates                 :password, length: { minimum: 6, on: :create }
    user.validates                 :display_name, length: { in: 2..32 }, :allow_blank => true
    user.validates_presence_of     :email
    user.validates_presence_of     :full_name
    user.validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    user.validates                 :email, :uniqueness => { :case_sensitive => false }
  end

  def validate_guest_order
    self.errors.add(:full_name) if full_name.blank?
    self.errors.add(:email) unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    self.errors.add(:credit_card_number) unless credit_card_number =~ /^\d{16}$/
    self.errors.add(:billing_street) if billing_street.blank?
    self.errors.add(:billing_city) if billing_city.blank?
    self.errors.add(:billing_state) unless billing_state =~ /^\D{2}$/
    self.errors.add(:billing_zip_code) unless billing_zip_code =~ /^\d{5}$/
    return false if self.errors.present?
    return true unless self.errors.present?
  end

  def self.new_guest
    new{ |u| u.guest = true }
  end

  def has_unsubmitted_orders?
    orders.where(status: "unsubmitted").any?
  end

  def unsubmitted_order
    orders.where(status: "unsubmitted").last
  end

  def name
    guest ? "Guest" : email
  end

  def move_to(user)
    orders.update_all(user_id: user.id)
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.new_guest_user_id
    @user = User.new_guest
    return @user.id if @user.save
  end

  def display_name_available?
    if display_name != ""
      display_name
    else
      full_name
    end
  end

  def authenticated?
    self.password_hash?
  end

  def restaurant_admin?
    # is current user_id == any jobs user ids
    # is that jobs role admin?
    if @current_user
      job = Job.where(user_id: @current_user.id)
      job.role == "Admin"
    else false
    end
  end

private

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end

end
