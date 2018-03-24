class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.belongs_to :category, index: true

      t.string :title
      t.string :factory
      t.string :style
      t.string :facade
      t.string :structure
      t.string :type
      t.string :transformation_type
      t.integer :width
      t.integer :height
      t.integer :depth

      t.timestamps
    end
  end
end
