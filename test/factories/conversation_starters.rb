# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation_starter do
    campaign
    text "@user Merry Christmas, #presents #cold #notgoinanywhere"
  end
end
