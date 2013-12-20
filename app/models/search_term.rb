class SearchTerm < ActiveRecord::Base
	belongs_to :campaign
	has_many :excluded_terms

	def excluded_term_strings
    return self.excluded_terms.map{ |term| term = term.text }
  end
end
