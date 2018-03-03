class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string, null: false, default: ""
    add_column :users, :last_name, :string, null: false, default: ""
    add_column :users, :phone, :string
    add_column :users, :city, :string
    add_column :users, :subscribe, :boolean, null: false, default: false
  end
end