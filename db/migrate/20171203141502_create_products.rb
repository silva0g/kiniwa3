class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :listing_name
      t.text :summary
      t.integer :price
      t.boolean :active
      t.string :product_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
