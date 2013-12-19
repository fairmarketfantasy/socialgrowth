class CreateSearchTerms < ActiveRecord::Migration
  def change
    create_table :search_terms do |t|
      t.integer :campaign_id
      t.string :text

      t.timestamps
    end
  end
end
