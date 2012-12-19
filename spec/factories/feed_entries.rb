# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed_entry do
    title "MyString"
    summary "MyText"
    url "MyString"
    published_at "2012-12-18 19:17:35"
    guid "MyString"
  end
end
