class ConversationStarter < ActiveRecord::Base
  belongs_to :campaign

  validate :has_valid_type

  def has_valid_type
    errors.add(:base, "type can't be #{self.type.blank? ? "blank" : self.type}") unless ConversationStarter.select_options.include? self.type
  end

  def self.select_options
    descendants.map{ |c| c.to_s }.sort
  end

  def self.inherited(child)
    child.instance_eval do
      def model_name
        ConversationStarter.model_name
      end
    end
    super
  end

  def conversation_format
    "@user"
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
