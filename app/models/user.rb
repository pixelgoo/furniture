class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable  

  attr_accessor :terms_of_service

  validates :first_name, presence: true
  validates :phone, numericality: { only_integer: true, allow_nil: true }
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates_acceptance_of :terms_of_service

  monetize :account_cents, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :role
  belongs_to :tariff, required: false

  def role_name=(name)
    self.role = Role.where(name: name).first
  end

  def role_name
     self.role.name
  end

  def full_name
    self.last_name.nil? ? self.first_name : "#{self.first_name} #{self.last_name}"
  end
end
