class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :is_active
      t.integer :spams_per_day, default: 1
      t.boolean :should_auto_activate
      t.integer :tweets_sent_count
      t.integer :authentication_id

      t.timestamps
    end
  end
end
