class TwitterAuthentication < Authentication
  def self.application_auth
    return Twitter::REST::Client.new do |config|
      config.consumer_key        = TWITTER_KEY
      config.consumer_secret     = TWITTER_SECRET
    end
  end

  def single_user_auth
    return Twitter::REST::Client.new do |config|
      config.consumer_key        = TWITTER_KEY
      config.consumer_secret     = TWITTER_SECRET
      config.access_token        = auth.access_token
      config.access_token_secret = auth.access_secret
    end
  end

  def client
    begin
      client = single_user_auth
      client.user
    rescue
      client = TwitterAuthentication.application_auth
    end
    return client
  end
end
