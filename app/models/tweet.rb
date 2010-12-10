class Tweet < ActiveRecord::Base
  belongs_to :voter
  belongs_to :chain
  belongs_to :choice

  def before_create
    identify_chain && identify_choice && score 
  end

  def voter
    @voter ||= Voter.new
  end
  
  protected
  
  def identify_chain
    self.chain = Chain.for_tweet(self)
  end
  
  def identify_choice
    self.choice = Choice.for_tweet(self)
  end
  
  # possible race condition in which a vote does not get counted?
  def score
    puts "Attempting Scoring Niceness..."
    choice.try(:upvote) # should we check to see if they've voted before?
    chain.try(:upvote)
    chain.try(:update_results)
  end
end