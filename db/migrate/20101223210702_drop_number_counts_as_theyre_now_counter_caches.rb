class DropNumberCountsAsTheyreNowCounterCaches < ActiveRecord::Migration
  def self.up
    remove_column :choices, :number
    remove_column :chains, :number
  end

  def self.down
    add_column :choices, "number", :integer, :default => 0
    add_column :chains, "number", :integer, :default => 0
  end
end
