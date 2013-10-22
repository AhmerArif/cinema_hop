# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showtime do
    movie
    cinema
    showing_at Time.now
  end
end
