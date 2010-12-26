class ChainsController < ApplicationController
  caches_page :show

  def new
    @chain = Chain.new
  end
  
  def index
    @chains = Chain.all
  end
  
  def show
    @chain = Chain.find(params[:id])
    @choices = @chain.choices.by_votes
  end
  
  def create
    @chain = Chain.create!(:anchor => params[:chain][:anchor], :words => params[:chain][:choices])
    unless @chain.errors.size > 0
      redirect_to chains_path
    else
      redirect_to new_chain_path
    end
  end
  
end