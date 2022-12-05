FactoryBot.define do
  factory :link do
    name { "VK" }
    url { "https://vk.com" }
    linkable { create(:question) }

    trait :gist do
      url { 'https://gist.github.com/schacon/1' }
    end
  end
end
