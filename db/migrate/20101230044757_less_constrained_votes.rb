class LessConstrainedVotes < ActiveRecord::Migration
  def self.up
    remove_index "votes", ["voter_id", "chain_id"]
    add_index "votes", ["voter_id", "chain_id", "choice_id"], :unique => true
  end

  def self.down
    remove_index "votes", ["voter_id", "chain_id", "choice_id"]
    add_index "votes", ["voter_id", "chain_id"], :unique => true
  end
end
