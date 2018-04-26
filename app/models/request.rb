class Request < ApplicationRecord
    belongs_to :customer, :class_name => 'User'
    belongs_to :manufacturer, :class_name => 'User', optional: true
    belongs_to :product

    scope :archived, -> { where(archived: true) }
    scope :newest, -> { where({ archived: false, successful: false }) }
    scope :successful, -> { where({ archived: false, successful: true }) }

    def archive!
        self.newest = false
        self.archived = true
        self.save
    end

    def satisfy!
        self.newest = false
        self.successful = true
        self.save
    end
end
