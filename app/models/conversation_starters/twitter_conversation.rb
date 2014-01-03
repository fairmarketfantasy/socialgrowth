class TwitterConversation < ConversationStarter
	belongs_to :twitter_campaign
	
  def conversation_format
  	"@user"
  end
end