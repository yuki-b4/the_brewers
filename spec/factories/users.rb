FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials(number: 3)}
    email {Faker::Internet.free_email}
    password =  Faker::Internet.password(min_length: 6)
    password {password + "b4"}
    password_confirmation {password + "b4"}
    job_id { 3 }
    drink_coffee_id { 3 }
  end
end
