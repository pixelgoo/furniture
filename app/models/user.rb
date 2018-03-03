class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable  

  attr_accessor :terms_of_service

  validates :phone, numericality: { only_integer: true, allow_nil: true }
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates_acceptance_of :terms_of_service
end
