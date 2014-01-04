class Authentication < ActiveRecord::Base
  belongs_to :user
  has_many :communications
  
  validate :has_a_valid_provider
  validates_presence_of :uid
  validates_presence_of :access_token
  validates_presence_of :access_secret
  #validates_presence_of :user

  self.inheritance_column = 'provider'

  def has_a_valid_provider
	   errors.add(:base, "No valid provider present") unless Authentication.valid_providers.include? self.provider
	end

  def self.valid_providers
  	return ["TwitterAuthentication"]
  end
end
