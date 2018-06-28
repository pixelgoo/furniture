class CreateJoinTableFurnituresUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :furnitures, :users do |t|

    end
  end
end
