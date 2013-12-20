module CampaignModules::TwitterCampaign
  def tweet_person(person, message)
    begin
      self.authentication.twitter_client.update "@#{person} check out #{self.title}. #baws #mode"
    rescue Exception => msg
      puts msg
    end
  end

  def find_related_tweets
    tweets = []
    for term in self.search_terms
      tweets.concat(get_search_results term)
    end
    return tweets
  end

  def get_search_results(search_term)
    begin
      tweets = []

      self.authentication.twitter_client.search("#{search_term.text}", count: number_of_tweets_to_grab, result_type: "recent").collect do |tweet|
        next unless tweet.text.include? search_term.text
        next if contains_excluded_term(tweet, search_term)

        tweets.push(format_result tweet)
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

    def contains_excluded_term(tweet, search_term)
      excluded_terms = search_term.excluded_terms.map { |term| term = Regexp.escape term.text }.join('|')
      return Regexp.new(excluded_terms, Regexp::IGNORECASE).match tweet.text
    end

    def find_followers(auth)
    end
end