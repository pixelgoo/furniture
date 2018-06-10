# frozen_string_literal: true

class Request < ApplicationRecord
  before_create :generate_token

  belongs_to :customer, :class_name => 'User'
  belongs_to :manufacturer, :class_name => 'User', optional: true
  belongs_to :product

  STATUSES = %w(new active successful archived)

  def set_status(status, manufacturer)
    return false unless STATUSES.include? status || status == 'new'
    self.status = status
    self.save
  end

  def assign_to_manufacturer(manufacturer)
    new_request = self.dup
    new_request.customer = self.customer
    new_request.product = self.product
    new_request.manufacturer = manufacturer
    new_request.save
    new_request.token = self.token
    new_request.save
    new_request
  end

  protected

  def generate_token
    self.token = loop do
    random_token = SecureRandom.hex(10)
    break random_token unless Request.exists?(token: random_token)
    end
  end

end
