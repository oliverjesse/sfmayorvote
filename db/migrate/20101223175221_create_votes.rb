class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :voter_id, :null => false
      t.integer :tweet_id, :null => false
      t.integer :choice_id, :null => false
      t.integer :chain_id, :null => false

      t.timestamps
    end
    add_index :votes, [:voter_id, :chain_id], :unique => true
  end

  def self.down
    drop_table :votes
  end
end
