FactoryBot.define do
  sequence :title do |n|
    "Question#{n}"
  end

  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    user { create(:user) }

    trait :invalid do
      title { nil }
    end

    trait :numbered do
      title
    end
  end
end
