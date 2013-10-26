require 'faker'
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :movie do
    name Faker::Name.name
    imdb_link 'http://'+Faker::Internet.domain_name
    rotten_tomatoes_link 'http://'+Faker::Internet.domain_name
    language 'English'
    poster { fixture_file_upload(Rails.root.join('spec', 'support', 'test.jpg'), 'image/jpg') }
  end
end