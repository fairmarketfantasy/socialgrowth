FactoryGirl.define do

  factory :user do
  end

  factory :twitter_authentication do
    provider "TwitterAuthentication"
    uid 12345
    access_token 'x'
    access_secret 'y'
    
    after(:build) do
      user = build(:user)
    end
  end
  
end

