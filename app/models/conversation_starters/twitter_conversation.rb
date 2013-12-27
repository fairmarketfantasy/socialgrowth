class TwitterConversation < ConversationStarter
  validate :has_valid_format

  def format
  	"@user"
  end
end