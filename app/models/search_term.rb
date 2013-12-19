class SearchTerm < ActiveRecord::Base
	belongs_to :campaign
	has_many :excluded_terms
end
