class Chain < ActiveRecord::Base
  has_many :choices, :dependent => :destroy, :inverse_of => :chain
  has_many :tweets, :inverse_of => :chain
  has_many :votes, :inverse_of => :chain
  
  scope :active, where(:active => true)

  before_save :update_choices

  validates :anchor, :presence => true, :uniqueness => true

  attr_accessor :words
  alias_attribute :term, :anchor

  def update_percentages
    if reload.votes_count > 0
      choices(true).each do |c|
        c.update_attribute(:percent, c.calculate_percentage)
      end
    end
  end

  def terms
    anchor.split
  end

  class << self
    def terms
      @@terms ||= active.map(&:anchor).flatten
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

  def update_choices
    if words.present?
      words.split(/,/).each do |w|
        choices << Choice.new(:term => w)
      end
    end
  end

end