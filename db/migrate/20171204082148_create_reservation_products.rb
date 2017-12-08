class CreateReservationProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :reservation_products do |t|
      t.references :reservation
      t.references :product
      t.integer :quantity
      t.timestamps
    end
  end
end
