class AddLinkToChoices < ActiveRecord::Migration
  def self.up
    add_column :choices, :link, :string
  end

  def self.down
    remove_column :choices, :link
  end
end