module AuthModules::TwitterModule
  def twitter_application_auth(auth = self)
    return Twitter::REST::Client.new do |config|
      config.consumer_key        = TWITTER_KEY
      config.consumer_secret     = TWITTER_SECRET
    end
  end

  def twitter_single_user_auth(auth = self)
    return Twitter::REST::Client.new do |config|
      config.consumer_key        = TWITTER_KEY
      config.consumer_secret     = TWITTER_SECRET
      config.access_token        = auth.access_token
      config.access_token_secret = auth.access_secret
    end
  end

	def send_tweet(auth = self)
    begin
  	  client = auth.twitter_single_user_auth auth
  		client.update "New advertisement! Coming at you from socialgrowth :)"
    rescue Exception => msg
      puts msg
    end
	end

  def find_followers(auth)
  end
end