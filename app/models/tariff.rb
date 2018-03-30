class Tariff < ApplicationRecord
    monetize :price_cents
    has_many :users
    has_many :payments, through: :users
end
