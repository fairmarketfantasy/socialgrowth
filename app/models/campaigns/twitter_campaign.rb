class TwitterCampaign < Campaign
	belongs_to :twitter
  has_many :twitter_conversations

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
    return conversation_starter.replace_format("@#{tweet.user.screen_name}"
  end

  def add_communication(tweet, message)
    Communication.create(search_string: self.search_string, text_found: tweet.text, text_sent: message, 
      username: tweet.user.screen_name, authentication: self.authentication)
  end

  def spam_people
    tweets = find_related_posts
    tweets.each do |tweet|
      next if self.authentication.communications.select { |comm| comm.username == tweet.user.screen_name }.count > 0 
      #message_person tweet
      test_message tweet 
    end
  end

  def find_related_posts
    begin
      return self.authentication.client.search("#{self.search_string}", count: self.spams_per_day, result_type: "recent").collect
    rescue Exception => msg
      puts msg
    end
  end

  def self.search(string, count)
    return TwitterAuthentication.application_auth.search("#{string}", count: count, result_type: "recent").collect
  end

  private

    def format_result(tweet)
      string = "#{tweet.user.screen_name}: #{tweet.text}"
      return string
    end

    def find_followers(auth)
    end
end