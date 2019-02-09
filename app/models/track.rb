class Track < ApplicationRecord
  has_and_belongs_to_many :genres
  validates :sc_id, presence: true
  validates :url, presence: true
  validates :artist, presence: true
  validates :title, presence: true
end
