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

  protected

  def set_defaults
    self.chain ||= Chain.for_tweet(self)
    self.choice ||= Choice.for_tweet(self)
  end

  def related_tweets
    voter.tweets.where(:chain_id => chain.id).votable
  end
end
