class AddRegionsCounterToTariff < ActiveRecord::Migration[5.1]
  def change
    add_column :tariffs, :region_counter, :integer, default: 24
  end
end
