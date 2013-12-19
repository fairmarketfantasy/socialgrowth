require 'test_helper'

class CampaignTest < ActiveSupport::TestCase

  test "Can create a campaign" do 
  	campaign = build(:campaign)

  	assert campaign.valid?, "Campaign contains errors: " + campaign.errors.full_messages.to_s
  end

end
