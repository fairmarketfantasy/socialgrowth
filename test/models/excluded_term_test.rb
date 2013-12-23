require 'test_helper'

class ExcludedTermTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Can exclude certain terms from results" do
  	campaign = create(:twitter_campaign)
  	auth = campaign.authentication
  	term_1 = create(:search_term, text: "cloud", campaign: campaign)
  	exclude_1 = create(:excluded_term, text: "humid", search_term: term_1)
  	exclude_2 = create(:excluded_term, text: "temperature", search_term: term_1)
  	exclude_3 = create(:excluded_term, text: "nine", search_term: term_1)
  	
  	tweets = campaign.find_related_posts
  end
end
