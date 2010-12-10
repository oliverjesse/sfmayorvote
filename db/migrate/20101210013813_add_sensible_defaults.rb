class AddSensibleDefaults < ActiveRecord::Migration
  def self.up
    change_column_default :chains, :number, 0
    change_column_default :choices, :number, 0
  end

  def self.down
    change_column_default :choices, :number, nil
    change_column_default :chains, :number, nil
  end
end