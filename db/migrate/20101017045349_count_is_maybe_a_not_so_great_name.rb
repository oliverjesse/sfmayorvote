class CountIsMaybeANotSoGreatName < ActiveRecord::Migration
  def self.up
    rename_column :chains, :count, :number
    rename_column :options, :count, :number
  end

  def self.down
    rename_column :options, :number, :count
    rename_column :chains, :number, :count
  end
end
