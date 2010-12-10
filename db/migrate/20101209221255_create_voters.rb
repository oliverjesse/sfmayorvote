class CreateVoters < ActiveRecord::Migration
  def self.up
    create_table :voters, :force => true do |t|
      t.string  :screen_name
      t.string  :name
      t.string  :twitter_id
      t.string  :profile_image_url
      t.timestamps
    end
  end

  def self.down
    drop_table :voters
  end
end