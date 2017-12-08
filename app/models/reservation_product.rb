class ReservationProduct < ApplicationRecord
  belongs_to :reservation
  belongs_to :product
end
