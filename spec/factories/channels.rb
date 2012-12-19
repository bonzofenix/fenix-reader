# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :channel do
    url 'www.valid_rss.com'
    trait :with_user do
      user
    end
  end
end
