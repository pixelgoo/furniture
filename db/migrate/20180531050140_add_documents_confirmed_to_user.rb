class AddDocumentsConfirmedToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :documents_confirmed, :boolean, default: false
  end
end
