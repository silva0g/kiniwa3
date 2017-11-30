class AddFieldsToMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :latitude, :float
    add_column :menus, :longitude, :float
  end
end
