class Campaign < ActiveRecord::Base
	belongs_to :authentication
  belongs_to :user

  has_many :conversation_starters
  has_many :communications

  validates_presence_of :authentication
  validates_presence_of :title

  #before_save :remove_empty_conversation_starters
  validate :has_atleast_one_conversation_starter
  validate :no_invalid_conversation_starters

  accepts_nested_attributes_for :conversation_starters, allow_destroy: true, reject_if: :conversation_starter_invalid?

  def has_atleast_one_conversation_starter
    unless num_valid_conversation_starters > 0
      errors.add(:base, "Must have at least one valid conversation starter!")
    end
  end
  
  def no_invalid_conversation_starters
    unless num_invalid_conversation_starters < 1
      errors.add(:base, "Can't have any invalid conversation starters. #{type}'s conversation starters must have '#{cs_requirement}' in them")
    end
  end

  def self.inherited(child)
    child.instance_eval do
      def model_name
        Campaign.model_name
      end
    end
    super
  end

  def num_valid_conversation_starters
    count = 0
    self.conversation_starters.each do |cs|
      count += 1 if valid_cs(cs.text)
    end
    return count
  end

  def num_invalid_conversation_starters
    count = 0
    self.conversation_starters.each do |cs|
      count += 1 unless valid_cs(cs.text)
    end
    return count
  end

  def remove_empty_conversation_starters
    self.conversation_starters.each do |conversation_starter|
      conversation_starter.delete unless valid_cs(conversation_starter.text)
    end
  end

  def conversation_starter_invalid?(attributes)
    is_valid = valid_cs(attributes['text'])
    return !is_valid
  end

	def is_active_string
		return self.is_active ? "active" : "inactive"
	end

  def provider
    return self.type.gsub "Campaign", ""
  end

  def amount_of_spam_sent_today
    return self.communications.where(['created_at >= ?', DateTime.now.beginning_of_day]).count
  end

  def should_spam?
    sent = self.amount_of_spam_sent_today
    expected = self.spams_per_day
    return sent < expected
  end

  def self.spam
    Campaign.where("is_active = ?", true).each do |campaign|
      campaign.spam_people if campaign.should_spam?
    end
  end
end
