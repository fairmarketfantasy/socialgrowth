# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation_starter do
    association :campaign, factory: :twitter_campaign
    text "@user Merry Christmas, #presents #cold #notgoinanywhere"
  end
end
