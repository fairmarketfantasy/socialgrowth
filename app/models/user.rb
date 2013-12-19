class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :authentications
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  validate :has_a_valid_authentication

  def has_a_valid_authentication
    errors.add(:base, "Has to have at least one authentication") unless self.authentications.length > 0
  end

  def twitter
  	return self.authentications.select { |auth| auth.provider = "twitter" }.first
  end
   
  def assign_name(omniauth)
  	self.name = omniauth[:info][:name]
  end
end
