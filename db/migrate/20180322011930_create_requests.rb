class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :token
      t.belongs_to :product, index: true
      t.references :customer
      t.references :manufacturer
      t.string :status, default: 'new'

      t.timestamps
    end

    add_foreign_key :requests, :users, column: :customer_id, primary_key: :id
    add_foreign_key :requests, :users, column: :manufacturer_id, primary_key: :id
  end
end
