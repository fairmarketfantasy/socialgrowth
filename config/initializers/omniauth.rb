Rails.application.config.middleware.use OmniAuth::Builder do
	#provider :twitter, "CONSUMER_KEY", "CONSUMER_SECRET"
	provider :twitter, TWITTER_KEY, TWITTER_SECRET
end