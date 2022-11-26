FactoryBot.define do
  sequence :body do |n|
    "text text #{n}"
  end

  factory :answer do
    body
    question
    user

    trait :with_files do
      files { [Rack::Test::UploadedFile.new(Rails.root.join('spec/rails_helper.rb'))] }
    end

    trait :invalid do
      body { nil }
    end
  end
end
