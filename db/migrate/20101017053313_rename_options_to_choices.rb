class RenameOptionsToChoices < ActiveRecord::Migration
  def self.up
    rename_table :options, :choices
  end

  def self.down
    rename_table :choices, :options
  end
end
