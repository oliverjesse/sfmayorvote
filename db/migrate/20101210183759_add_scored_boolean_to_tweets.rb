class AddScoredBooleanToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :scored, :boolean, :default => false
  end

  def self.down
    remove_column :tweets, :scored
  end
end