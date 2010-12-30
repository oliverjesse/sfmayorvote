class ConstrainVoters < ActiveRecord::Migration
  def self.up
    change_column_null :voters, :twitter_id, false
    change_column_null :voters, :screen_name, false
  end

  def self.down
    change_column_null :voters, :twitter_id, true
    change_column_null :voters, :screen_name, true
  end
end
