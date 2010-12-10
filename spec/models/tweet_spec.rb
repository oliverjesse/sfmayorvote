require 'spec_helper'

describe Tweet do
  before(:all) do
    @valid_attributes = {
      :text => "omg we all gotta #vote @MattGonzalez #mayor"
    }
    
    @invalid_attributes = {
      :text => "who would want to #vote for #sfmayor on twitter anyway???" # has chain but no choice
    }
  end
  
  describe "with blank text" do
    before(:each) do
      @tweet = Tweet.new
    end
    
    it "should be invalid" do
      lambda { @tweet.save }.should raise_error(ActiveRecord::RecordInvalid)
    end
    
    it "should not get a chain or a choice" do
      @tweet.chain.should be_nil
      @tweet.choice.should be_nil
    end    
  end
  
  describe "with non-blank text" do
    before(:each) do
      @tweet = Tweet.new(@valid_attributes)
    end
    
    describe "chain" do
      it "should have terms found in tweet text" do
        @tweet.chain.terms.each do |term|
          @tweet.text.should =~ /#{term}/
      end
    end

    describe "choice" do
      before(:each) do
        @tweet = Tweet.new(@valid_attributes)
      end

      it "should have a term found in tweet text" do
        @tweet.text.should =~ /#{@tweet.choice.term}/
      end

      it "should be from the same chain" do
        @tweet.choice.chain_id.should_not be_nil
        @tweet.chain_id.should_not be_nil
        @tweet.choice.chain_id.should == @tweet.chain_id
      end
    end
  end
  
  pending "should only get assigned a chain and a choice on initialization if necessary" do
    
  end
  
  describe "scoring" do
    describe "for valid tweet" do
      before(:each) do
        @tweet = Tweet.new(@valid_attributes)
      end

      it "should happen before creation" do
        @tweet.scored.should be_false
        @tweet.save
        @tweet.scored.should be_true
      end

      it "should not happen on update" do
        # stub_model ?
      end

      it "should increment votes for choice" do
        count = @tweet.choice.number
        @tweet.save
        @tweet.choice.number.should == (count + 1)
      end

      it "should increment votes on chain" do
        count = @tweet.chain.number
        @tweet.save
        @tweet.chain.number.should == (count + 1)
      end

      it "should calculate new percentages for all choices" do
        choices = @tweet.chain.choices
        choices.map(&:percent).sum.should == 100
        old_percent = @tweet.choice.percent
        @tweet.save
        @tweet.choice.percent.should > old_percent
        choices.map(&:percent).sum.should == 100
      end
    end
    
    describe "for invalid tweet" do
      it "should not happen" do
        @tweet = Tweet.create!(@invalid_attributes)
        @tweet.scored.should be_false
      end
    end
  end

  
end