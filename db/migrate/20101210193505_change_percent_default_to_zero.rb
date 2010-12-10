class ChangePercentDefaultToZero < ActiveRecord::Migration
  def self.up
    change_column_default :choices, :percent, 0
  end

  def self.down
    change_column_default :choices, :percent, nil
  end
end