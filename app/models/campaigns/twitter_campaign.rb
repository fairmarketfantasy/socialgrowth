class TwitterCampaign < Campaign
	belongs_to :twitter

  def message_person(person)
    tweet_body = ""
    begin
      conversation_starter = ConversationStarter.random(self.conversation_starters)
      tweet_body = conversation_starter.replace_format("@#{person}")
      self.authentication.client.update tweet_body
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
    tweets = []
    self.search_terms.each do |term|
      tweets.concat(get_search_results term)
    end
    return tweets
  end

  def get_search_results(search_term)
    begin
      tweets = []

      self.authentication.client.search("#{search_term.text}", count: number_of_tweets_to_grab, result_type: "recent").collect do |tweet|
        next unless tweet.text.include? search_term.text
        next if search_term.contains_excluded_term tweet.text

        puts tweet.text
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
      puts string
      return string
    end

    def find_followers(auth)
    end
end