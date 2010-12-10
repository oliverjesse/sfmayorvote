class VotesController < ApplicationController
  
  def create
    Chain.vote(params[:termpair], params[:status])
  end
  
end