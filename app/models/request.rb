class Request < ApplicationRecord
    monetize :amount_cents

    belongs_to :user
    belongs_to :product
    has_one :payment

    validates :type, presence: true, allow_blank: false
end
