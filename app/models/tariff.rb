class Tariff < ApplicationRecord
    monetize :price_cents
    has_many :users
end
