class VoteSweeper < ActionController::Caching::Sweeper
  observe Vote

  def after_create(vote)
    expire_page(:controller => 'chains', :action => 'show', :id => vote.chain_id)
  end
end
