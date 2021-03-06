require 'spec_helper'

def setup_poll
  @chain = Chain.new(
    :anchor => "#vote #nosepiercings"
  )
  @chain.choices << Choice.new(
    :term => "#awesome"
  )
  @chain.choices << Choice.new(
    :term => "#ugly"
  )
  @chain.save
end


describe Tweet do
  before(:all) do
    @voter = (Voter.where(:screen_name => "nk").first || Voter.create!(
      :screen_name => "nk",
      :twitter_id => 777
    ))
    
    @valid_attributes = {
      :text => "omg we all gotta #vote #awesome for #nosepiercings !!!",
      :voter => @voter,
      :twitter_id => 666
    }
    
    @alternate_attributes = {
      :text => "omg #nosepiercings are soooooo #ugly #vote",
      :voter => @voter,
      :twitter_id => 555
    }
    
    @nonvote_attributes = {
      :text => "who would want to #vote for #nosepiercings on twitter anyway???", # has chain but no choice
      :voter => @voter,
      :twitter_id => 555 # also has no twitter_id
    }
  end
  
  describe "with blank text" do
    before(:each) do
      @tweet = Tweet.new
    end
    
    it "should be invalid" do
      @tweet.save.should be_false
    end
    
    it "should not get a chain or a choice" do
      @tweet.chain.should be_nil
      @tweet.choices.should be_empty
    end    
  end
  
  describe "with non-blank text" do
    before(:all) do
      setup_poll
    end

    before(:each) do
      @tweet = Tweet.new(@valid_attributes)
    end
    
    it "should have a voter, chain and choice id after saving if valid" do
      @tweet.save
      @tweet.choices.should be_present
      @tweet.chain_id.should_not be_nil
      @tweet.voter_id.should_not be_nil
    end
    
    describe "chain" do
      it "should have terms found in tweet text" do
        @tweet.chain.terms.each do |term|
          @tweet.text.should =~ /#{term}/
        end
      end
    end

    describe "choice" do
      before(:each) do
        @tweet = Tweet.new(@valid_attributes)
      end

      it "should have a term found in tweet text" do
        @tweet.text.should =~ /#{@tweet.choices.first.term}/
      end

      it "should be from the same chain" do
        @tweet.chain.should_not be_nil
        @tweet.choices.each do |choice|
          choice.chain.should == @tweet.chain
        end
      end
    end
  end
  
  it "should only get assigned a chain and a choice on initialization if necessary" do
    
  end
  
  describe "scoring" do
    before(:all) do
      setup_poll
    end
    
    describe "for valid tweet" do
      before(:each) do
        @tweet = Tweet.new(@valid_attributes)
      end

      it "should happen before creation" do
        @tweet.scored.should be_false
        @tweet.save!
        @tweet.scored.should be_true
      end

      it "should not happen on update" do
        # stub_model ?
      end

      it "should increment votes for choice" do
        count = @tweet.choices.first.votes_count
        @tweet.save!
        @tweet.choices(true).first.votes_count.should == (count + 1)
      end

      it "should increment votes on chain" do
        count = @tweet.chain.votes_count
        @tweet.save!
        @tweet.chain(true).votes_count.should == (count + 1)
      end

      it "should calculate new percentages for all choices" do
        all_choices = @tweet.chain.choices
        [0,1].should include all_choices.map(&:percent).sum
        old_percent = @tweet.choices.first.percent
        @tweet.save!
        @tweet.choices(true).first.percent.should > old_percent
        all_choices.reload.map(&:percent).sum.should == 1
      end
      
      describe "for different replacement vote" do
        before(:each) do
          @prior_tweet = Tweet.create!(@valid_attributes)
          @current_tweet = Tweet.new(@alternate_attributes)
        end
        
        it "should retract the prior vote" do
          old_count = @prior_tweet.choices(true).first.votes_count
          @current_tweet.save!
          @prior_tweet.choices(true).first.votes_count.should == (old_count - 1)
        end
        
        it "should record the appropriate choice" do
          old_count = @current_tweet.choices.first.votes_count
          @current_tweet.save
          @current_tweet.reload.choices.first.votes_count.should == (old_count + 1)
        end
      end
    end
    
    describe "for invalid tweet" do
      it "should not happen" do
        @tweet = Tweet.create!(@nonvote_attributes)
        @tweet.scored.should be_false
      end
    end
  end
end