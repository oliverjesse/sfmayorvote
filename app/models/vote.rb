class Vote < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :voter
  belongs_to :choice, :counter_cache => true
  belongs_to :chain, :counter_cache => true
end
