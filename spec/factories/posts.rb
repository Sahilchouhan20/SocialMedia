FactoryBot.define do
  factory :post do
    text { "Sample text" }
    user
    # Add any other attributes required by your Post model
  end
end
