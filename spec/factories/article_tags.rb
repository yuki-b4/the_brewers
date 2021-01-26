FactoryBot.define do
  factory :article_tag do
    title { Faker::Lorem.sentence }
    detail { Faker::Lorem.sentence }
    how_brew { Faker::Lorem.sentence }
    why_brew { Faker::Lorem.sentence }
    commit { Faker::Lorem.sentence }
    taste { Faker::Lorem.sentence }
    name { Faker::Lorem.word }
    user_id { Faker::Number.within(range: 1..10) }
  end
end
