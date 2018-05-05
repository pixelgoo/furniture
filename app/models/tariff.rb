class Tariff < ApplicationRecord
    monetize :price_cents
    has_many :users
    has_many :payments, through: :users

    STATUSES = ['active', 'inactive']

    def price_per_day
        self.price / 30
    end
end
