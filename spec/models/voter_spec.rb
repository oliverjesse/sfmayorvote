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

  it "should create a new instance given valid attributes" do
    Voter.create!(@valid_attributes)
  end
  
  it "should have many tweets" do
    
  end
  
  it "should always have at least one tweet" do
    
  end
  
  it "should have a unique screen name and twitter id" do
    
  end

end