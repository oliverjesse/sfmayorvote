class ChangeForeignKeyName < ActiveRecord::Migration
  def self.up
    rename_column :choices, :chain_id, :markov_chain_id
  end

  def self.down
    rename_column :choices, :markov_chain_id, :chain_id
  end
end
