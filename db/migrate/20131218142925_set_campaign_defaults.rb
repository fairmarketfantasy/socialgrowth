class SetCampaignDefaults < ActiveRecord::Migration
  def change
  	change_column :campaigns, :is_active, :boolean, default: false
  	change_column :campaigns, :should_auto_activate, :boolean, default: false
  	change_column :campaigns, :tweets_sent_count, :integer, default: 0
  	change_column :campaigns, :spams_per_day, :integer, default: 0
  end
end
