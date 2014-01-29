module ApplicationHelper
	def status_color(is_dangerous)
		if is_dangerous
			return "danger"
		end
		return "success"
  end

  def enabled_color(is_enabled)
    return "enabled-color" if is_enabled
    return "disabled-color"
  end

  def display_hash(tweet)
  	tweet.created_at.day == DateTime.now.day ? date = tweet.created_at.strftime("%l:%M %P") : date = tweet.created_at.strftime("%b %d, %y") 
  	return { author: tweet.user.name, text: tweet.text, date: date } 
  end

end
