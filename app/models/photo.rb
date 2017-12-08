class Photo < ApplicationRecord
  # belongs_to :menu
  belongs_to :imageable, polymorphic: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def menu
    if self.imageable_type == 'Menu'
      Menu.find_by(id: self.imageable_id)
    end
  end

  def product
     if self.imageable_type == 'Product'
      Product.find_by(id: self.imageable_id)
    end
  end
end
