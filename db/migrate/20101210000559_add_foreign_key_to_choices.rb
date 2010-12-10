class AddForeignKeyToChoices < ActiveRecord::Migration
  def self.up
    add_column :choices, :chain_id, :integer
  end

  def self.down
    remove_column :choices, :chain_id
  end
end