require "rails_helper"
RSpec.describe "Tracks" do
  let(:genre_house) { create(:genre, name: "house") }
  let(:category_chill) { create(:category, name: "Chill Out") }

  context "no tweeted tracks in genre" do
    it "returns tracks in genre by tweet_tracks" do
      tracks = create_list(:track, 3, genres: [genre_house])
      tweet_tracks = Track.tweet_tracks(genre_house, 3)
      tracks.each do |track|
        expect(tweet_tracks).to include(track)
      end
      expect(tweet_tracks.size).to eq(3)
    end
  end

  context "untweeted tracks more than tweet_tracks size in genre" do
    it "returns untweeted tracks tweet_tracks" do
      untweeted_tracks = create_list(:track, 3, genres: [genre_house])
      tweeted_tracks = create_list(:track, 3, tweeted_at: 1.day.ago, genres: [genre_house])
      tweet_tracks = Track.tweet_tracks(genre_house, 3)
      untweeted_tracks.each do |track|
        expect(tweet_tracks).to include(track)
      end
      expect(tweet_tracks.size).to eq(3)
    end
  end

  context "untweeted tracks less than tweet_tracks size in genre" do
    it "returns all untweeted tracks in genre by tweet_tracks" do
      untweeted_tracks = create_list(:track, 2, genres: [genre_house])
      tweeted_tracks = create_list(:track, 3, tweeted_at: 1.day.ago, genres: [genre_house])
      tweet_tracks = Track.tweet_tracks(genre_house, 3)
      untweeted_tracks.each do |track|
        expect(tweet_tracks).to include(track)
      end
      expect(tweet_tracks.size).to eq(3)
      # tweet_tracksからuntweeted_tracksを除いた残りはtweeted_tracksであるはず
      (tweet_tracks-untweeted_tracks).each do |track|
        expect(tweeted_tracks).to include(track)
      end
    end
  end
end
