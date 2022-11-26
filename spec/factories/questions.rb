FactoryBot.define do
  sequence :title do |n|
    "Question#{n}"
  end

  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    user

    trait :with_files do
      files { [Rack::Test::UploadedFile.new(Rails.root.join('spec/rails_helper.rb'))] }
    end

    trait :invalid do
      title { nil }
    end

    trait :numbered do
      title
    end
  end
end
