FactoryBot.define do
  factory :reward do
    title { 'Reward title' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/thinknetica.png')) }
    question

    trait :no_image do
      image { nil }
    end
  end
end
