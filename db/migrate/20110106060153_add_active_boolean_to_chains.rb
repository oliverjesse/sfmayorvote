class AddActiveBooleanToChains < ActiveRecord::Migration
  def self.up
    add_column :chains, :active, :boolean, :default => true
  end

  def self.down
    remove_column :chains, :active
  end
end