class TwitterAuthentication < Authentication

  def self.application_auth
    puts "application auth"
    return Twitter::Client.new(
      consumer_key: TWITTER_KEY,
      consumer_secret: TWITTER_SECRET)
  end

  def single_user_auth
    return Twitter::REST::Client.new do |config|
      config.consumer_key        = TWITTER_KEY
      config.consumer_secret     = TWITTER_SECRET
      config.access_token        = self.access_token
      config.access_token_secret = self.access_secret
    end
  end

  def old_authentication
    puts "old client auth"
    return Twitter::Client.new(
      consumer_key: TWITTER_KEY,
      consumer_secret: TWITTER_SECRET,
      oauth_token: self.access_token, 
      oauth_token_secret: self.access_secret)
  end

  def client
    begin
      #client = single_user_auth
      client = old_authentication
      client.user
    rescue
      client = TwitterAuthentication.application_auth
    end
    return client
  end
end
