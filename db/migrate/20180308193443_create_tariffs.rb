class CreateTariffs < ActiveRecord::Migration[5.1]
  def change
    create_table :tariffs do |t|

      t.string :name
      t.monetize :price
      t.text :description
      t.integer :months

      t.timestamps
    end
  end
end
