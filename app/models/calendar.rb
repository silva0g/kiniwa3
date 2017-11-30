class Calendar < ApplicationRecord
  enum status: [:Disponible, :Pas_Disponible]
  validates :day, presence: true
  belongs_to :menu
end
