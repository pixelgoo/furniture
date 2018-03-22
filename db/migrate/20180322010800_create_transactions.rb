class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|

      t.belongs_to :request, index: true
      t.string :action
      t.integer :amount
      t.string :currency, default: "UAH"
      t.string :confirm

      t.timestamps
    end
  end
end
