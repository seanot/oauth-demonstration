require 'faker'

FactoryGirl.define do
  factory :identity do
    association :user
    provider "google_oauth_2"
    uid { Faker::Number.number(10) }

  end
end
