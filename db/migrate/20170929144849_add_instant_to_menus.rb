class AddInstantToMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :instant, :integer, default: 1
  end
end
