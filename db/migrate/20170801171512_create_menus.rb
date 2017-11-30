class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :menu_type
      t.string :assiete_type
      t.integer :servings
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :is_salee
      t.boolean :is_sucree
      t.boolean :is_gluten
      t.boolean :is_epicee
      t.integer :price
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
