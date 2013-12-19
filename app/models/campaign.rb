class Campaign < ActiveRecord::Base
	belongs_to :authentication
	has_many :search_terms

  validates_presence_of :authentication
  
	def is_active_string
		return self.is_active ? "active" : "inactive"
	end
end
