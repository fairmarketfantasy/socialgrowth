class CreateConversationStarters < ActiveRecord::Migration
  def change
    create_table :conversation_starters do |t|
      t.integer :campaign_id
      t.string :text
      t.string :type

      t.timestamps
    end
  end
end
