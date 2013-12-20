class SearchTerm < ActiveRecord::Base
	belongs_to :campaign
	has_many :excluded_terms

	def excluded_term_strings
    return self.excluded_terms.map{ |term| term = term.text }
  end

  def contains_excluded_term(text)
    excluded_terms = self.excluded_terms.map { |term| term = Regexp.escape term.text }.join('|')
    return Regexp.new(excluded_terms, Regexp::IGNORECASE).match text
  end

end
