# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showtime do
    movie
    cinema
    showing_at "2013-10-22 19:13:22"
  end
end
