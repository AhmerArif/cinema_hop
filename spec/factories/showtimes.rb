FactoryGirl.define do
  factory :showtime do
    movie
    cinema
    showing_at Time.now
    adults_only false
    is_3d false
  end
end