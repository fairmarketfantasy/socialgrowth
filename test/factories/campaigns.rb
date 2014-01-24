FactoryGirl.define do

  factory :twitter_campaign, class: Campaign do
    association :authentication, factory: :twitter_authentication
    type "TwitterCampaign"
    title "Oracle"
    search_string "cloud computing -stocks"

    after_build do |campaign|
    	build(:twitter_conversation, campaign: campaign)
    end
  end

end