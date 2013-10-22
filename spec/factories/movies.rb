require 'faker'

FactoryGirl.define do
  factory :movie do
    name Faker::Name.name
    imdb_link 'http://'+Faker::Internet.domain_name
    rotten_tomatoes_link 'http://'+Faker::Internet.domain_name
  end
end
