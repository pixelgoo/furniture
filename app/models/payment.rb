class Payment < ApplicationRecord
    belongs_to :user

    validates :amount, format: { with: /\A\d+(\.{1}\d{1,2})?\z/, message: "Invalid amount format" }
end
