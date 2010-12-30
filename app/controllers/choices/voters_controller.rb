class Choices::VotersController < ApplicationController
  def index
    @choice = Choice.find(params[:choice_id])
    @votes = @choice.votes
    render :layout => false
  end
end
