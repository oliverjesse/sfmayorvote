class DropMarkovChainId < ActiveRecord::Migration
  def self.up
    remove_column :choices, :markov_chain_id
    change_column_null :choices, :chain_id, false
    change_column_null :tweets, :twitter_id, false
    change_column_null :tweets, :voter_id, false
  end

  def self.down
    add_column :choices, :markov_chain_id, :integer
    change_column_null :choices, :chain_id, true
    change_column_null :tweets, :twitter_id, true
    change_column_null :tweets, :voter_id, true
  end
end
