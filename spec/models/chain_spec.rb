require 'spec_helper'

describe Chain do
  before(:each) do
    @chain = Chain.new(:anchor => "#make #contact")
    @chain.choices = [ Choice.new(:term => "@foo"), Choice.new(:term => "@bar") ]
    @chain.save
  end
  
  it "should calculate percentages for all its choices" do
    @chain = Chain.create!(
      :anchor => "foo",
      :votes_count => 57
    )
    @chain.choices << Choice.create!(:term => "a", :votes_count => 23)
    @chain.choices << Choice.create!(:term => "b", :votes_count => 4)
    @chain.choices << Choice.create!(:term => "c", :votes_count => 30)
    @chain.update_percentages
    @chain.choices.each do |c|
      c.percent.should > 0
    end
  end
  
  describe "for tweet" do
    before(:each) do
      @tweet = Tweet.new(:text => "I'd like to #make #contact with @foo")
      @chain = @tweet.chain
    end
    
    it "should be found" do
      @chain.should be_present
    end
    
    it "should be found regardless of case" do
      old_chain = @chain
      @tweet = Tweet.new(:text =>@tweet.text.upcase)
      @tweet.chain.should be_present
      old_chain.id.should == @tweet.chain.id
    end
  end
  
end