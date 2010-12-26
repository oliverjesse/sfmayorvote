class Chains::VotersController < ApplicationController
  def show
    @voter = Voter.find_by_twitter_id(params[:id], :include => {:votes => :choice}, :conditions => {:votes => {:chain_id => params[:chain_id]}})
    render :json => @voter.to_json(:include => {:votes => {:include => :choice}})
  end
end
