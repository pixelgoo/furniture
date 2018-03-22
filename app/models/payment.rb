class Payment < ApplicationRecord
    belongs_to :request, optional: true
    belongs_to :tariff, optional: true

    validates :amount, format: { with: /\A\d+(\.{1}\d{1,2})?\z/, message: "Invalid amount format" }
end
