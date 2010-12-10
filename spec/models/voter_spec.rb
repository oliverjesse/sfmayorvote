require 'spec_helper'

describe Voter do
  before(:all) do
    # @race = Race.create!(:name => "Unicorn Mountain")
    # @candidate = Candidate.create!(:name => "John Smith", :race => @race)
  end

  before(:each) do
    @valid_attributes = {
      :body => "value for body",
      :race_id => @race.id,
      :source_id => 0,
      :created_at => Time.now,
      :updated_at => Time.now,
      :candidate_id => -1
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