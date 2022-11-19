FactoryBot.define do
  sequence :body do |n|
    "text text #{n}"
  end

  factory :answer do
    body
    user { create(:user) }

    trait :invalid do
      body { nil }
    end
  end
end
