class Tweet < ActiveRecord::Base
  belongs_to :voter, :inverse_of => :tweets
  belongs_to :chain, :inverse_of => :tweets

  has_many :tweet_choices
  has_many :choices, :through => :tweet_choices
  has_many :votes, :inverse_of => :tweet

  after_initialize :refresh_associations
  after_create :score

  validates :text, :presence => true

  scope :votable, joins(:tweet_choices)

  # possible race condition in which a vote does not get counted?
  def score
    if valid? && chain && choices.present?
      prior_tweet = related_tweets.joins(:votes).first
      return if prior_tweet && prior_tweet.tweeted_at > tweeted_at
      prior_tweet.votes.destroy_all if prior_tweet
      choices.each do |choice|
        votes.create!(
          :voter_id => voter_id,
          :choice_id => choice.id,
          :chain_id => chain_id
        )
      end
      chain.update_percentages
      self[:scored] = true
    end
  end

  def refresh_associations
    self.chain = related_chain
    self.choices = related_choices
  end

  def tweeted_at
    self[:tweeted_at] || created_at
  end

  protected

  def related_chain
    # must have all words from term but in any order
    Chain.all.detect do |c|
      c.term.split.all? {|word| text =~ /#{word}/i }
    end
  end

  def related_choices
    # must have ANY words from term in any order
    return [] if !chain
    chain.choices.select do |c|
      c.term.split.any? {|word| text =~ /(?:[^a-zA-Z0-9]|^)#{word}(?:[^a-zA-Z0-9]|$)/i }
    end
  end

  def related_tweets
    voter.tweets.where(:chain_id => chain.id).votable
  end
end
