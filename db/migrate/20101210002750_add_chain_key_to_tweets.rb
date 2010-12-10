class AddChainKeyToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :chain_id, :integer
  end

  def self.down
    remove_column :tweets, :chain_id
  end
end