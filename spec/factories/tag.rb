FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "genre #{n}" }
  end
end
