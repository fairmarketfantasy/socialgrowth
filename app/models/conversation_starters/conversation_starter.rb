class ConversationStarter < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :twitter_campaign

  def has_valid_format
    errors.add(:base, "Format must contain: #{format}") unless self.text.include? format
  end

  def provider
    return self.type
  end

  def self.random(conversation_starters)
    item = rand(0..(conversation_starters.length-1))
    return conversation_starters[item]
  end


  # If needed this could be factored out into another table 
  # An conversation has_many formats
  # Format table: provider:string text:string
  # replace_format would take a provider and parameters to replace each or designated formats
  def replace_format(format_text)
    return self.text.gsub(self.format, format_text)
  end


end
