# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.username }
    bio { Faker::Lorem.sentence }
    # You might need to handle avatar differently if it's a file upload
    email {Faker::Internet.email}
    password { 'password' }
    password_confirmation { 'password' }
  end
end
