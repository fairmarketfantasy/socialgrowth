module AuthModules::TwitterAuth
  def twitter_application_auth
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

  def twitter_client(auth = self)
    begin
      client = twitter_single_user_auth auth
      client.user
    rescue
      client = twitter_application_auth
    end
    return client
  end
end