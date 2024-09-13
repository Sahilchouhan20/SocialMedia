FactoryBot.define do
  factory :post do
    association :user
    text { "This is a sample post text" }

    trait :with_image do
      after(:build) do |post|
        post.images.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'image.png')),
          filename: 'image.png',
          content_type: 'image/png'
        )
      end
    end
  end
end
