require 'faker'

FactoryGirl.define do
  factory :cinema do
    name {Faker::Company.name}
    city
    website {"http://"+Faker::Internet.domain_name}
    address {Faker::Address.street_address}
  end
end