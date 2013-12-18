class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :authentications
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  def twitter
  	return self.authentications.select { |auth| auth.provider = "twitter" }.first
  end
   
  def assign_name(omniauth)
  	self.name = omniauth[:info][:name]
  end

  def assign_nickname(omniauth)
  	self.nickname = omniauth[:info][:nickname]
  end
end
