class TweetChoice < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :choice
end
