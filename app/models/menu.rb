class Menu < ApplicationRecord
  # Kinywa 3
  enum instant: {Request: 0, Instant: 1} 

  #---- Kinywa 2 ----
  belongs_to :user
  # has_many :photos
  has_many :photos, as: :imageable
  has_many :reservations

  has_many :client_reviews
  has_many :calendars

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :menu_type, presence: true
  validates :assiete_type, presence: true
  validates :servings, presence: true
  #validates :bed_room, presence: true
  #validates :bathroom, presence: true

  def cover_photo(size)

  	if self.photos.length > 0
  		self.photos[0].image.url(size)

  	else 
  		"blank.jpg"
  	end

  end

  def average_rating

    client_reviews.count == 0 ? 0 : client_reviews.average(:star).round(2).to_i
  end

end
