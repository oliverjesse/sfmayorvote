class Tweet < ActiveRecord::Base
  belongs_to :voter, :inverse_of => :tweets
  belongs_to :chain, :inverse_of => :tweets
  belongs_to :choice, :inverse_of => :tweets

  has_one :vote, :inverse_of => :tweet

  after_initialize :set_defaults
  after_create :score

  validates :text, :presence => true

  scope :votable, where("tweets.choice_id is not null")

  # possible race condition in which a vote does not get counted?
  def score
    if valid? && chain && choice
      prior_tweet = related_tweets.joins(:vote).first
      return if prior_tweet && prior_tweet.created_at > created_at
      prior_tweet.vote.destroy if prior_tweet
      create_vote(
        :voter_id => voter_id,
        :choice_id => choice_id,
        :chain_id => chain_id
      )
      chain.update_percentages
      self[:scored] = true
    end
  end
  
  class << self
    def audit(tweet)
      if Tweet.find_by_twitter_id(tweet['id'])
        return false
      else
        user = Twitter.user(tweet['from_user'])
        voter = Voter.find_or_initialize_by_screen_name(user['screen_name'])
        voter[:profile_image_url] = user['profile_image_url']
        voter[:twitter_id] = user['id']
        voter[:name] = user['name']
        voter.save!
        tweet = voter.tweets.build(
          'twitter_id' => tweet['id'],
          'text' => tweet['text']
        )
        tweet.save!
        return true
      end
    end
  end

  def refresh_associations
    self.chain = Chain.for_tweet(self)
    self.choice = Choice.for_tweet(self)
  end

  protected

  def set_defaults
    self.chain ||= Chain.for_tweet(self)
    self.choice ||= Choice.for_tweet(self)
  end

  def related_tweets
    voter.tweets.where(:chain_id => chain.id).votable
  end
end
