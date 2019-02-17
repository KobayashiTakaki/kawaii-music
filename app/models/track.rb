class Track < ApplicationRecord
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :categories
  validates :sc_id, presence: true
  validates :url, presence: true
  validates :artist, presence: true
  validates :title, presence: true
  paginates_per 5

  scope :random, -> (size) {
    self.where(id: self.pluck(:id).shuffle[0..size-1])
        .order_random
  }
  scope :order_random, -> { order(:random_order) }
  scope :undescribed, -> { where(description: [nil, '']) }
  scope :by_genre_id, -> (genre_id) {
    where(id: Genre.find(genre_id).tracks.ids)
  }
  scope :include_genres, -> { includes(:genres) }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # DBに存在すればnext
      next if find_by(sc_id: row["sc_id"])

      track = new
      # CSVからデータを取得し、設定する
      track.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      track.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["sc_id", "url", "artist", "title"]
  end

  def self.tweet_tracks(theme, size)
    tracks = []
    if size > theme.not_tweeted_tracks.size
      tracks += theme.not_tweeted_tracks
      size_rest = size - theme.not_tweeted_tracks.size
      tracks += theme.tweeted_tracks.sample(size_rest)
    else
      tracks += theme.not_tweeted_tracks.sample(size)
    end
  end

  def self.pick_theme
    model = [Genre, Category].sample
    id = model.pluck(:id).sample
    model.find(id)
  end

  def self.tweet_theme(least_tracks_size=3, max_retry=3)
    theme = nil
    retry_count = 0
    # 一定数trackがあるテーマを選ぶ
    while (theme.nil? or theme.tracks.size < least_tracks_size) \
          and (retry_count < max_retry) do
      theme = pick_theme
      retry_count += 1
    end
    theme
  end

  def add_genre(name)
    Genre.create(name: name) unless Genre.find_by(name: name)
    genre = Genre.find_by(name: name)
    unless self.genres.include?(genre)
      self.genres << genre
    end
  end

  def delete_genre(id)
    genre = Genre.find(id)
    self.genres.delete(genre)
  end

  def add_category(name)
    Category.create(name: name) unless Category.find_by(name: name)
    category = Category.find_by(name: name)
    unless self.categories.include?(category)
      self.categories << category
    end
  end

  def delete_category(id)
    category = Category.find(id)
    self.categories.delete(category)
  end

  def tweeted?
    return true if tweeted_at.present?
    return false
  end

end
