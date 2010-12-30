class CreateTweetChoices < ActiveRecord::Migration
  class Tweet < ActiveRecord::Base
    belongs_to :choice
    has_many :tweet_choices
    has_many :choices, :through => :tweet_choices
  end

  def self.up
    create_table :tweet_choices do |t|
      t.integer :tweet_id, :null => false
      t.integer :choice_id, :null => false

      t.timestamps
    end
    add_index :tweet_choices, :tweet_id
    add_index :tweet_choices, :choice_id
    add_index :tweet_choices, [:tweet_id, :choice_id], :unique => true

    Tweet.where('choice_id is not null').find_each do |tweet|
      next unless tweet.choice
      tweet.choices << tweet.choice
    end
    remove_column :tweets, :choice_id
  end

  def self.down
    drop_table :tweet_choices
  end
end
