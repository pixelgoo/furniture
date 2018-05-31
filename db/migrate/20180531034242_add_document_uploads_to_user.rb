class AddDocumentUploadsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :files_uploaded, :integer, default: 0
  end
end
