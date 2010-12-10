class CreateChains < ActiveRecord::Migration
  def self.up
    create_table :chains, :force => true do |t|
      t.string :term
      t.string :started_at
      t.integer :count
      t.timestamps
    end
  end

  def self.down
    drop_table :chains
  end
end
