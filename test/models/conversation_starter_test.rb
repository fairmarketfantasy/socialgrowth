require 'test_helper'

class ConversationStarterTest < ActiveSupport::TestCase
  
  test "Can create a valid conversation starter" do
    conversation = build(:conversation_starter)

    assert conversation.valid?, "Should be a valid conversation but has errors: " + conversation.errors.full_messages.to_s
  end

  test "Can send conversation starters" do 
    campaign = create(:twitter_campaign)
    term_1 = create(:search_term, text: "cloud", campaign: campaign)
    exclude_1 = create(:excluded_term, text: "humid", search_term: term_1)

    starter_1 = create(:conversation_starter, campaign: campaign)
    starter_2 = create(:conversation_starter, campaign: campaign, text: "And the winner is... @user! #thingsyouwishwouldhappen")
    starter_3 = create(:conversation_starter, campaign: campaign, text: "@user Ho ho ho, who wouldn't know? #notthensa")

    campaign.spam_people
  end
end
