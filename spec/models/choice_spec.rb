require 'spec_helper'

describe Choice do
  before(:each) do
    @choice = Choice.new(:term => "@foo")
    @chain = Chain.create!(
      :anchor => "#make #contact",
      :choices => [ @choice, Choice.new(:term => "@bar") ])
  end

  it "should belong to a chain" do
    @choice.chain.should be_present
  end

  it "should have many tweets" do

  end

  describe "for tweet" do
    before(:each) do
      @tweet = Tweet.new(:text => "I'd like to #make #contact with @foo")
      @choices = @tweet.choices
    end

    it "should be found" do
      @choices.should be_present
    end

    it "should be found regardless of case" do
      old_choices = @choices
      @tweet = Tweet.new(:text =>@tweet.text.upcase)
      @tweet.choices.should be_present
      old_choices.should =~ @tweet.choices
    end

    it "should contain at least one word from term that matches tweet text" do
      Choice.where(:term => "@foo").first.update_attribute(:term, "@foo fue foo")
      @tweet = Tweet.new(:text => "I'd like to #make #contact with @foo")
      @tweet.choices.should be_present
      @tweet.choices.should =~ @choices
    end
  end

end