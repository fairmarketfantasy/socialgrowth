# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search_term do
    association :campaign, factory: :twitter_campaign
    text "cloud"
  end
end
