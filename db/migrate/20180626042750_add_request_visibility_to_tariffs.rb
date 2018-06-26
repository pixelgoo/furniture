class AddRequestVisibilityToTariffs < ActiveRecord::Migration[5.1]
  def change
    add_column :tariffs, :request_visibility, :integer
  end
end
