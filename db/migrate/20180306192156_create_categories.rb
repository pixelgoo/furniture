class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|

      t.string :title
      t.belongs_to :furniture, index: true

      t.timestamps
    end
  end
end
