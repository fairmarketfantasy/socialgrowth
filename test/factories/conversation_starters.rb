# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :twitter_conversation do
    type "TwitterConversation"
    text "@user Merry Christmas, #presents #cold #notgoinanywhere"
  end
end
