class CreateJoinTableProductTextile < ActiveRecord::Migration[5.1]
  def change
    create_join_table :products, :textiles do |t|
      # t.index [:product_id, :textile_id]
      # t.index [:textile_id, :product_id]
    end
  end
end
