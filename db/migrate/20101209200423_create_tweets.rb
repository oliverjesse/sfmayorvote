class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets, :force => true do |t|
      t.string :twitter_id
      t.string :user_screen_name
      t.string :user_name
      t.string :user_id
      t.string :text
      t.string :user_profile_image_url
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end