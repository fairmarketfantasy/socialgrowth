class ConversationStarter < ActiveRecord::Base
  belongs_to :campaign

  validate :has_valid_format

  def has_valid_format
    errors.add(:base, "Format must contain: " + formats[provider]) unless self.text.include? formats[provider]
  end

  def provider
    return self.campaign.type
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
    return self.text.gsub(formats[provider], format_text)
  end
  
  def formats
    return { "TwitterCampaign" => "@user" }
  end


end
