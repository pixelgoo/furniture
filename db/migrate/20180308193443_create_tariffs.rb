class CreateTariffs < ActiveRecord::Migration[5.1]
  def change
    create_table :tariffs do |t|

      t.string :name
      t.monetize :price
      t.text :description

      t.timestamps
    end
  end
end
