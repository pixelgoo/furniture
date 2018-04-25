class Request < ApplicationRecord
    belongs_to :user
    belongs_to :product

    scope :archived, -> { where(archived: true) }
    scope :newest, -> { where({ archived: false, successful: false }) }
    scope :successful, -> { where({ archived: false, successful: true }) }
end
