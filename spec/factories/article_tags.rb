FactoryBot.define do
  factory :article_tag do
    title { Faker::Lorem.sentence }
    detail { Faker::Lorem.sentence }
    how_brew { Faker::Lorem.sentence }
    why_brew { Faker::Lorem.sentence }
    commit { Faker::Lorem.sentence }
    taste { Faker::Lorem.sentence }
    name { Faker::Lorem.word }
    user_id { 3 }
  end
end
