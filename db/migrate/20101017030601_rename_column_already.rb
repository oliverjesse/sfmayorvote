class RenameColumnAlready < ActiveRecord::Migration
  def self.up
    rename_column :chains, :term, :anchor
  end

  def self.down
    rename_column :chains, :anchor, :term
  end
end
