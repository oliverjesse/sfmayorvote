class Chain < ActiveRecord::Base
  has_many :choices, :dependent => :destroy
  has_many :tweets
  before_save :update_choices

  validates :anchor, :presence => true, :uniqueness => true

  attr_accessor :words

  def update_percentages
    if number > 0
      choices.reload.each do |c|
        c.update_attribute(:percent, c.calculate_percentage)
      end
    end
  end

  def terms
    anchor.split
  end

  class << self
    # must have all words from term but in any order
    def for_tweet(tweet)
      Chain.find_each do |c|
        words = c.term.split
        found = true
        words.each do |w|
          found = (found && (tweet.text =~ /#{w}/i))
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
      _choice = _chain.choices.where(:term => _choice_term).first
      # puts "Found an choice with id #{_choice.id}"
      _chain.increment!(:number)
      _choice.increment(:number)
      _choice.percent = (_choice.number / _chain.number * 100)
      _choice.save
    end
  end
  
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