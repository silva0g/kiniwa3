class Product < ApplicationRecord
  belongs_to :user
  #has_many :photos
  has_many :photos, as: :imageable

  def cover_photo(size)

    if self.photos.length > 0
      self.photos[0].image.url(size)

    else 
      "blank.jpg"
    end

  end
end
