class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable  

  attr_accessor :terms_of_service

  validates :first_name, presence: true, length: { maximum: 14 }
  validates :last_name, length: { maximum: 14 }
  validates :phone, allow_blank: true, format: { with: /\d+/ }
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }
  validates :password, confirmation: true
  validates_acceptance_of :terms_of_service

  belongs_to :role
  belongs_to :tariff, optional: true
  has_many :payments
  has_many :customer_requests, :class_name => 'Request', :foreign_key => 'customer_id'
  has_many :manufacturer_requests, :class_name => 'Request', :foreign_key => 'manufacturer_id'
  has_and_belongs_to_many :regions

  # =====================================================================================
  # General
  # =====================================================================================

  def full_name
    self.last_name.nil? ? self.first_name.capitalize : "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

  # =====================================================================================
  # Role
  # =====================================================================================

  def role_name=(name)
    self.role = Role.where(name: name).first
  end

  def role_name
    self.role.name
  end

  def manufacturer?
    self.role_name == 'Manufacturer'
  end

  def customer?
    self.role_name == 'Customer'
  end

  # =====================================================================================
  # Tariff
  # =====================================================================================

  def set_tariff(tariff)
    self.tariff = Tariff.find_by(name: tariff)
    self.save
    self.tariff_enddate = DateTime.now + self.tariff.months.months
    self.save
  end

  def tariff_active?
    self.tariff_enddate.present? ? self.tariff_enddate > DateTime.now : false
  end

  # =====================================================================================
  # Requests
  # =====================================================================================

  def request(id)
    token = Request.find(id).token
    self.send("#{self.role_name.downcase}_requests").find_by(token: token)
  end

end
