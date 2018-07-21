class AddTrialToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :trial, :integer, default: 14
  end
end
