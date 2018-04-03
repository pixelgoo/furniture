class CreateTextiles < ActiveRecord::Migration[5.1]
  def change
    create_table :textiles do |t|

      t.string :name
      
      t.timestamps
    end
  end
end
