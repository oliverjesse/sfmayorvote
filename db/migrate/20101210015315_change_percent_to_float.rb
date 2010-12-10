class ChangePercentToFloat < ActiveRecord::Migration
  def self.up
    change_column :choices, :percent, :float
  end

  def self.down
    change_column :choices, :percent, :integer
  end
end