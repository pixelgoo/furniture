class FixRegionsColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :regions, :name, :title
  end
end
