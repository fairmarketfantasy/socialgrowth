module CampaignModules::TwitterCampaign
  def tweet_person(person)
    tweet_body = ""
    begin
      conversation_starter = ConversationStarter.random(self.conversation_starters)
      tweet_body = conversation_starter.replace_format("@#{person}")
      self.authentication.twitter_client.update tweet_body
    rescue Exception => msg
      puts msg.to_s + ".\r\nCouldn't tweet: " + tweet_body
    end
  end

  def spam_tweets
    tweets = find_related_tweets
    tweets.each do |tweet|
      tweet_person tweet.user.screen_name
    end
  end

  def find_related_tweets
    tweets = []
    self.search_terms.each do |term|
      tweets.concat(get_search_results term)
    end
    return tweets
  end

  def get_search_results(search_term)
    begin
      tweets = []

      self.authentication.twitter_client.search("#{search_term.text}", count: number_of_tweets_to_grab, result_type: "recent").collect do |tweet|
        next unless tweet.text.include? search_term.text
        next if search_term.contains_excluded_term tweet.text

        tweets.push(tweet)
      end
    rescue Exception => msg
      puts msg
    end
    return tweets
  end

  private

    def number_of_tweets_to_grab
      return self.spams_per_day*2
    end

    def format_result(tweet)
      string = "#{tweet.user.screen_name}: #{tweet.text}"
      return string
    end

    def find_followers(auth)
    end
end