require 'test_helper'

class ConversationStarterTest < ActiveSupport::TestCase
  
  test "Can create a valid conversation starter" do
    conversation = build(:twitter_conversation)

    assert conversation.valid?, "Should be a valid conversation but has errors: " + conversation.errors.full_messages.to_s
  end

  test "Can send conversation starters" do 
    campaign = create(:twitter_campaign)

    starter_1 = create(:twitter_conversation, campaign: campaign)
    starter_2 = create(:twitter_conversation, campaign: campaign, text: "And the winner is... @user! #thingsyouwishwouldhappen")
    starter_3 = create(:twitter_conversation, campaign: campaign, text: "@user Ho ho ho, who wouldn't know? #notthensa")

    campaign.spam_people
  end
end
