class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.string :search_string
      t.string :text_found
      t.string :text_sent
      t.string :username
      t.integer :authentication_id
      t.integer :campaign_id
      
      t.timestamps
    end
  end
end
