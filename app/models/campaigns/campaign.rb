class Campaign < ActiveRecord::Base
	belongs_to :authentication
  belongs_to :user
  has_many :conversation_starters
  
  accepts_nested_attributes_for :conversation_starters

  validates_presence_of :authentication
  validates_presence_of :title

	def is_active_string
		return self.is_active ? "active" : "inactive"
	end

  def provider
    return self.type.gsub "Campaign", ""
  end
end
