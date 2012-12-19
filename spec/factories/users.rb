
FactoryGirl.define do
  factory :user do
    email 'homero@thompson.com'
    first_name 'homero'
    password '123456'
    max_channels 10
    confirmed_at Time.now
  end
end
