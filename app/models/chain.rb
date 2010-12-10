class Chain < ActiveRecord::Base
  has_many :choices, :dependent => :destroy
  has_many :tweets
  before_save :update_choices
  
  validates_presence_of :anchor
  validates_uniqueness_of :anchor
  
  attr_accessor :words

  def update_results
    update_percentages
  end
  
  def update_percentages
    if number > 0
      choices.reload.each do |c|
        c.update_attribute(:percent, c.calculate_percentage)
      end
    end
  end
  
  def upvote
    update_attribute(:number, number + 1)
  end
  
  def terms
    anchor.split
  end

  class << self
    # must have all words from term but in any order
    def for_tweet(tweet)
      Chain.all.each do |c|
        words = c.term.split
        found = true
        words.each do |w|
          found = (found && (tweet.text =~ /#{w}/))
        end
        return c if found
      end
      nil
    end
    
    def terms
      @@terms ||= all.map(&:anchor).flatten
    end
    
    def vote(termpair, s)
      _anchor = termpair.split.first
      _choice_term = termpair.split.last
      _chain = where(:anchor => _anchor).first
      # puts "Found a chain with id #{_chain.id}."
      _choice = Choice.where(:chain_id => _chain.id).where(:term => _choice_term).first
      # puts "Found an choice with id #{_choice.id}"
      _chain.update_attribute(:number, (_chain.number || 0) + 1)
      _choice.number = (_choice.number || 0) + 1
      _choice.percent = (_choice.number / _chain.number * 100)
      _choice.save
    end
  end
  
  # def terms
  #   [].tap do |a|
  #     choices.map(&:term).each do |t|
  #       a << "#{anchor} #{t}"
  #     end
  #   end
  # end
  
  def term
    anchor
  end
  
  def term=(opts)
    anchor=(opts)
  end
  
  def update_choices
    if words.present?
      words.split(/,/).each do |w|
        choices << Choice.new(:term => w)
      end
    end
  end
  
end