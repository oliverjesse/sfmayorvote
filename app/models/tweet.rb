class Tweet < ActiveRecord::Base
  belongs_to :voter
  belongs_to :chain
  belongs_to :choice

  before_create :process
  
  validates :text, :presence => true

  def process
    identify_chain && identify_choice && score 
  end

  def voter
    self[:voter] ||= Voter.new
  end
  
  def chain
    self[:chain] ||= identify_chain
  end
  
  def choice
    self[:choice] ||= identify_choice
  end
  
  protected
  
  def identify_chain
    Chain.for_tweet(self)
  end
  
  def identify_choice
    Choice.for_tweet(self)
  end
  
  # possible race condition in which a vote does not get counted?
  def score
    if valid? && chain && choice
      puts "Attempting Scoring Niceness..."
      choice.upvote # should we check to see if they've voted before?
      chain.upvote
      chain.update_results
      self[:scored] = true
    end
  end
end