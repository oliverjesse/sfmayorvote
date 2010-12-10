class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options, :force => true do |t|
      t.string :term
      t.integer :count
      t.integer :rank
      t.integer :percent
      t.integer :chain_id
      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end
