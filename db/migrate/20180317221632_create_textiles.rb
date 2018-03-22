class CreateTextiles < ActiveRecord::Migration[5.1]
  def change
    create_table :textiles do |t|

      t.string :name
      t.belongs_to :product, index: true
      
      t.timestamps
    end
  end
end
