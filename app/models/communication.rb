class Communication < ActiveRecord::Base
	belongs_to :authentication
	belongs_to :campaign
	
end
