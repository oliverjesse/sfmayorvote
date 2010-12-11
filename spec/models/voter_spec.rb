require 'spec_helper'

describe Voter do
  before(:all) do
    # @race = Race.create!(:name => "Unicorn Mountain")
    # @candidate = Candidate.create!(:name => "John Smith", :race => @race)
  end

  before(:each) do
    @valid_attributes = {
      :screen_name => "oliverjesse",
      :name => "Jesse Sanford",
      :twitter_id => 12345
    }
  end

  describe "given valid attributes" do
    before(:each) do
      @voter = Voter.new(@valid_attributes)
    end
    
    it "should save without error" do
      @voter.save.should_not be_false
    end

    it "should have many tweets" do
      @voter.should respond_to(:tweets)
    end    
    
    it "should always have at least one tweet" do
      # hard to test ...
    end
  end
    
  describe "with duplicate screen name or twitter id" do
    it "should be invalid" do
      Voter.create!(@valid_attributes)
      old_count = Voter.count
      @voter2 = Voter.new(@valid_attributes)
      @voter2.save.should be_false
      old_count.should == Voter.count
    end
  end
end