FactoryBot.define do
  factory :comment do
    discription { "This is a sample comment description." }

    # If you have validations or associations, include them here.
    # For example, if a comment belongs to a post:
    association :post

    # If you have user associations:
    association :user
  end
end
