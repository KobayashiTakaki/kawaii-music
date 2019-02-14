FactoryBot.define do
  factory :track do
    sequence(:sc_id) { |n| n }
    sequence(:url) { |n| "https://example.com/tracks/#{n}" }
    sequence(:artist) { |n| "Artist#{n}" }
    sequence(:title) { |n| "Track Title #{n}" }
  end
end
