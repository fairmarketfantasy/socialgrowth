class Campaign < ActiveRecord::Base
	belongs_to :authentication
	has_many :search_terms
  has_many :conversation_starters
  
  validates_presence_of :authentication
  validates_presence_of :title

	def is_active_string
		return self.is_active ? "active" : "inactive"
	end

end
