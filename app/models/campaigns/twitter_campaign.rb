class TwitterCampaign < Campaign
	belongs_to :twitter
  has_many :twitter_conversations

  def cs_requirement
    return "@user"
  end

  def valid_cs(text)
    return !text.blank? && text.include?("@user")
  end

  def message_person(tweet)
    begin
      tweet_body = get_conversation_body tweet
      self.authentication.client.update tweet_body
      add_communication tweet, tweet_body
      self.tweets_sent_count += 1
    rescue Exception => msg
      puts msg.to_s + ".\r\nCouldn't tweet: " + tweet_body
    end
  end

  def test_message(tweet)
    tweet_body = get_conversation_body tweet
    puts tweet_body
    add_communication tweet, tweet_body
    self.tweets_sent_count += 1
  end

  def get_conversation_body(tweet)
    conversation_starter = ConversationStarter.random(self.conversation_starters)
    return conversation_starter.replace_format("@#{tweet.user.screen_name}")
  end

  def add_communication(tweet, message)
    Communication.create(search_string: self.search_string, text_found: tweet.text, text_sent: message, 
      username: tweet.user.screen_name, authentication: self.authentication, campaign: self)
  end

  def spam_people 
    tweets_sent_today = self.amount_of_spam_sent_today
    tweets_to_send = self.spams_per_day - tweets_sent_today
    tweets = find_related_posts
    puts "found #{tweets.count} tweets. Have #{tweets_to_send} tweets to send yet"
    tweets.each do |tweet|
      username = self.authentication.communications.where(['username = ?', tweet.user.screen_name]).first
      puts "username: #{username} twitter: #{tweet.user.screen_name} campaign: #{self.title}"
      next unless username.nil?
      break unless self.spams_per_day > tweets_sent_today
      message_person tweet
      #test_message tweet
      tweets_sent_today += 1
    end
  end

  def find_related_posts
    begin
      return self.authentication.client.search("#{self.search_string}", count: self.spams_per_day, result_type: "recent").statuses.collect
    rescue Exception => msg
      puts msg
    end
  end

  def self.search(string, count, user = nil, lang = "en")
    if user
      auth = user.authentications.where(["provider = ?", "TwitterAuthentication"]).first
      client = auth.client if auth
    end
    client = TwitterAuthentication.application_auth unless client
    return unless client
    tweets = client.search("#{string}", count: count, result_type: "recent", :lang => lang)
    return tweets.statuses.collect
  end

  private

    def format_result(tweet)
      string = "#{tweet.user.screen_name}: #{tweet.text}"
      return string
    end

    def find_followers(auth)
    end
end