require 'test_helper'

class SearchTermTest < ActiveSupport::TestCase

  test "Can add search terms to a campaign" do 
  	campaign = build(:twitter_campaign)
  	term_1 = build(:search_term, text: "cloud", campaign: campaign)
  	term_2 = build(:search_term, text: "computing", campaign: campaign)

  	assert campaign.valid?, "Adding search terms didn't work correctly: #{campaign.errors.full_messages.to_s}"
  	#assert campaign.search_criteria.length == 2, "Wrong number of search terms present, or failed to save: " + campaign.search_criterum.length
  	campaign.save
  	term_1.save
  	term_2.save
  	assert campaign.search_terms.length == 2, "Wrong number of search terms present, or failed to save: #{campaign.search_terms.length.to_s}"
  end

end
