class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable  

  attr_accessor :terms_of_service

  validates :first_name, presence: true, length: { maximum: 14 }
  validates :last_name, length: { maximum: 14 }
  validates :phone, allow_blank: true, format: { with: /\d+/ }
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates_acceptance_of :terms_of_service

  monetize :account_cents, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :role
  belongs_to :tariff, required: false

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

  def set_tariff_status(status)
    case status
      when :inactive
        self.tariff_status = 0
      when :active
        self.tariff_status = 1
      else
        raise 'Unrecognized tariff exception'
    end
  end

end
