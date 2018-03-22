class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|

      t.belongs_to :user, index: true
      t.belongs_to :product, index: true

      t.timestamps
    end
  end
end
