class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|

      t.string :type
      t.belongs_to :request, index: true
      t.belongs_to :tariff, index: true
      t.string :action
      t.string :amount
      t.string :currency, default: "UAH"
      t.string :confirm, default: 'no'

      t.timestamps
    end
  end
end
