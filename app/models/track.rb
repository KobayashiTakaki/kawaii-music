class Track < ApplicationRecord
  has_and_belongs_to_many :genres
  accepts_nested_attributes_for :genres, allow_destroy: true
  validates :sc_id, presence: true
  validates :url, presence: true
  validates :artist, presence: true
  validates :title, presence: true

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

end
