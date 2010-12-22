class Tweet < ActiveRecord::Base
  belongs_to :voter
  belongs_to :chain
  belongs_to :choice

  before_create :process
  after_initialize :set_defaults

  validates :text, :presence => true

  def process
    score 
  end

  protected

  def set_defaults
    self.chain ||= Chain.for_tweet(self)
    self.choice ||= Choice.for_tweet(self)
    self.voter ||= Voter.new
  end

  def related_tweets
    voter.tweets.where(:chain_id => chain.id).where("choice_id is not null")
  end

  def prior_tweet
    @prior_tweet ||= related_tweets.order("created_at desc").first
  end
  
  # does not currently update results
  def retract_prior_tweet
    prior_tweet.choice.decrement!(:number)
    prior_tweet.chain.decrement!(:number)
  end
  
  # possible race condition in which a vote does not get counted?
  def score
    if valid? && chain && choice
      unless prior_tweet.present?
        record_score
      else
        unless prior_tweet.choice.id == choice.id
          retract_prior_tweet
          record_score
        end
      end
      self[:scored] = true
    end
  end
  
  def record_score
    choice.increment!(:number) # should we check to see if they've voted before?
    chain.increment!(:number)
    chain.update_percentages
  end
end