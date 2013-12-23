FactoryGirl.define do

  factory :twitter_campaign do
    association :authentication, factory: :twitter_authentication
    title "Oracle"
  end

end