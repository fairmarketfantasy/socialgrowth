class AddNamesToUser < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :authentications, :nickname, :string
  end
end
