FactoryGirl.define do
  factory :showtime do
    movie
    cinema
    showing_at Time.now.midnight + 42.hours
    adults_only false
    is_3d false
  end
end