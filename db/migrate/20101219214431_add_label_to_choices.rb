class AddLabelToChoices < ActiveRecord::Migration
  def self.up
    add_column :choices, :label, :string
  end

  def self.down
    remove_column :choices, :label
  end
end