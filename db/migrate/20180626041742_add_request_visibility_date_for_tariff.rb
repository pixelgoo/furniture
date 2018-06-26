class AddRequestVisibilityDateForTariff < ActiveRecord::Migration[5.1]
  def change
    def change
      add_column :tariffs, :request_visibility, :datetime
    end
  end
end
