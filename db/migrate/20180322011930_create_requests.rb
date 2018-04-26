class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|

      t.belongs_to :product, index: true
      t.references :customer
      t.references :manufacturer
      t.boolean :newest, default: true
      t.boolean :archived, default: false
      t.boolean :successful, default: false

      t.timestamps
    end

    add_foreign_key :requests, :users, column: :customer_id, primary_key: :id
    add_foreign_key :requests, :users, column: :manufacturer_id, primary_key: :id
  end
end
