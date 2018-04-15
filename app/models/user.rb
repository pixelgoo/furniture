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

  monetize :account_cents, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :role
  belongs_to :tariff, optional: true
  has_many :payments
  has_many :requests

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
    self.tariff = Tariff.where(name: tariff).first
    self.set_tariff_status :active
  end

  def tariff_active?
    self.tariff_status == 1
  end

  def tariff_inactive?
    self.tariff_status == 0
  end

  def set_tariff_status(status)
    case status
      when :inactive
        self.tariff_status = 0
      when :active
        self.tariff_status = 1
      else
        raise 'Unrecognized tariff status exception'
    end
    self.save
  end

  def perform_tariff_payment
    if(self.account >= self.tariff.price_per_day) then
      self.account -= self.tariff.price_per_day
      self.save
    else
      self.set_tariff_status :inactive
    end
  end

  # =====================================================================================
  # Account
  # =====================================================================================
  
  def account=(number)
    self.account = number.delete(' ')
  end

end
