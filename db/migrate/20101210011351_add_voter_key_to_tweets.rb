class AddVoterKeyToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :voter_id, :integer
    remove_column :tweets, :user_id
    remove_column :tweets, :user_screen_name
    remove_column :tweets, :user_profile_image_url
    remove_column :tweets, :user_name
  end

  def self.down
    add_column :tweets, :user_name, :string
    add_column :tweets, :user_profile_image_url, :string
    add_column :tweets, :user_screen_name, :string
    add_column :tweets, :user_id, :string
    remove_column :tweets, :voter_id
  end
end
