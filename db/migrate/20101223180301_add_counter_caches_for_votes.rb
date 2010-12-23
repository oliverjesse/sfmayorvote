class AddCounterCachesForVotes < ActiveRecord::Migration
  def self.up
    add_column :choices, :votes_count, :integer, :default => 0
    add_column :chains, :votes_count, :integer, :default => 0
  end

  def self.down
    remove_column :choices, :votes_count
    remove_column :chains, :votes_count
  end
end
