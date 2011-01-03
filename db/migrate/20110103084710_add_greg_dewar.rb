class AddGregDewar < ActiveRecord::Migration
  def self.up
    Choice.create!(:chain_id => 1, :label => "Greg Dewar", :term => "@njudah @GregDewar GregDewar Dewar", :link => "http://www.njudahchronicles.com/")
  end

  def self.down
  end
end