class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|

      t.belongs_to :user, index: true
      t.string :order_id
      t.string :action
      t.string :tariff
      t.string :amount
      t.string :currency, default: "UAH"
      t.string :status

      t.timestamps
    end
  end
end
