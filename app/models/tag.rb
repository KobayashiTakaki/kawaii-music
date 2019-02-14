class Tag < ApplicationRecord
  has_and_belongs_to_many :tracks
  validates :name, presence: true

  def tweeted_tracks
    tracks.map{|t| t if t.tweeted?}.compact
  end

  def not_tweeted_tracks
    tracks.map{|t| t unless t.tweeted?}.compact
  end
end
