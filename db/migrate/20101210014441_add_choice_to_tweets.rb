class AddChoiceToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :choice_id, :integer
  end

  def self.down
    remove_column :tweets, :choice_id
  end
end