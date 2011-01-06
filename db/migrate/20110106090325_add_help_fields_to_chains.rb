class AddHelpFieldsToChains < ActiveRecord::Migration
  def self.up
    add_column :chains, :headline, :string
    add_column :chains, :intro, :text
    add_column :chains, :outro, :text
  end

  def self.down
    remove_column :chains, :outro
    remove_column :chains, :intro
    remove_column :chains, :headline
  end
end