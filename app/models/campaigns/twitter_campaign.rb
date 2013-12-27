class TwitterCampaign < Campaign
	belongs_to :twitter

  def message_person(person)
    tweet_body = ""
    begin
      conversation_starter = ConversationStarter.random(self.conversation_starters)
      tweet_body = conversation_starter.replace_format("@#{person}")
      self.authentication.client.update tweet_body
      self.tweets_sent_count += 1
    rescue Exception => msg
      puts msg.to_s + ".\r\nCouldn't tweet: " + tweet_body
    end
  end

  def spam_people
    tweets = find_related_posts
    tweets.each do |tweet|
      message_person tweet.user.screen_name
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
      puts string
      return string
    end

    def find_followers(auth)
    end
end