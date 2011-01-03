class AddTonyHall < ActiveRecord::Migration
  def self.up
    Choice.create!(:chain_id => 1, :label => "Tony Hall", :term => "@TonyHallSF @TonyHall TonyHall Tony Hall", :link => "http://en.wikipedia.org/wiki/Tony_Hall_(supervisor)")
  end

  def self.down
  end
end
