class CreateExcludedTerms < ActiveRecord::Migration
  def change
    create_table :excluded_terms do |t|
      t.integer :search_term_id
      t.string :text

      t.timestamps
    end
  end
end
