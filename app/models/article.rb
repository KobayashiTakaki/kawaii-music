class Article < ApplicationRecord
  has_one :track
  validates :comment, presence: true
end
