class Request < ApplicationRecord
    belongs_to :user
    belongs_to :product

    scope :archived, -> { where(archived: true) }
    scope :scope_new, -> { where({ archived: false, successful: false }) }
    scope :successful -> { where({ archived: false, successful: true }) }
end
