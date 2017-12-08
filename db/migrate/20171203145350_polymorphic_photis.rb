class PolymorphicPhotis < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :imageable_id, :integer
    add_column :photos, :imageable_type, :string

    add_index :photos, [:imageable_type, :imageable_id]

    update_old_records
  end

  def update_old_records
    old_photos = Photo.all
    old_photos.each do |photo|
      next if photo.menu_id.nil?
      photo.imageable_id = photo.menu_id
      photo.imageable_type = 'Menu'
      photo.menu_id = nil
      photo.save!
    end
  end
end
