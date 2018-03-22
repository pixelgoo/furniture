class Request < ApplicationRecord
    belongs_to :user
    belongs_to :product
    has_one :payment
end
