class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star, default: 1
      t.references :menu, foreign_key: true
      t.references :reservation, foreign_key: true
      t.references :client, foreign_key:  { to_table: :users }
      t.references :chef, foreign_key:  { to_table: :users }
      t.string :type

      t.timestamps
    end
  end
end

