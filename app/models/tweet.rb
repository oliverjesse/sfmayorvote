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

  # def voter
  #   self[:voter] ||= Voter.new
  # end
  
  # def chain
  #   self[:chain] ||= identify_chain
  # end
  # 
  # def choice
  #   self[:choice] ||= identify_choice
  # end
  
  protected
  
  def set_defaults
    self.chain ||= identify_chain
    self.choice ||= identify_choice
    self.voter ||= Voter.new
  end
  
  def identify_chain
    Chain.for_tweet(self)
  end
  
  def identify_choice
    Choice.for_tweet(self)
  end
  
  def prior_tweet
    @prior_tweet ||= Tweet.where(:voter_id => voter.id, :chain_id => chain.id).where("choice_id is not null").order("created_at desc").first
  end
  
  # does not currently update results
  def retract_prior_tweet
    prior_tweet.choice.update_attribute(:number, prior_tweet.choice.number - 1)
    prior_tweet.chain.update_attribute(:number, prior_tweet.chain.number - 1)
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
    chain.update_results
  end
end