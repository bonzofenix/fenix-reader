# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed_entry do
    title 'cool feed'
    summary 'this is a cool feed'
    url 'www.coolfeed.com/rss/32'
    published_at '2012-12-18 19:17:35'
    guid '1'
    stars 0
  end
end
