class AddUsersRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_regions, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :region, index: true
    end
  end
end
