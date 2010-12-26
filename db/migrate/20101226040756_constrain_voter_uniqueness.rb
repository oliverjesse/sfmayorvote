class ConstrainVoterUniqueness < ActiveRecord::Migration
  def self.up
    add_index :voters, :twitter_id, :unique => true
    add_index :voters, :screen_name # not unique because twitter screen names can be changed and we could end up with a conflict due to an outdated record, but potentially helpful for fast lookup
  end

  def self.down
    remove_index :voters, :twitter_id
    remove_index :voters, :screen_name
  end
end
