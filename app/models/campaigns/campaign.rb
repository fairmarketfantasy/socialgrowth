class Campaign < ActiveRecord::Base
	belongs_to :authentication
  belongs_to :user

  has_many :conversation_starters
  has_many :communications

  accepts_nested_attributes_for :conversation_starters

  validates_presence_of :authentication
  validates_presence_of :title

  before_save :remove_empty_conversation_starters
  before_save :has_atleast_one_conversation_starter

  def has_atleast_one_conversation_starter
    errors.add(:base, "Campaigns have to have a conversation starter") unless self.conversation_starters.count > 0
  end
  
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Campaign.model_name
      end
    end
    super
  end

  def remove_empty_conversation_starters
    self.conversation_starters.each do |conversation_starter|
      conversation_starter.delete if conversation_starter.text.blank?
    end
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
    puts "Sent: #{sent} vs. Expected: #{expected}"
    return sent < expected
  end

  def self.spam
    Campaign.where("is_active = ?", true).each do |campaign|
      puts "The campaign should #{campaign.should_spam? ? "" : "not"} tweet"
      campaign.spam_people if campaign.should_spam?
    end
  end
end
