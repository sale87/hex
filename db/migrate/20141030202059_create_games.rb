class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :description
      t.integer :creator_id
      t.integer :black_id
      t.integer :white_id
      t.time :accepted_at
      t.integer :time_per_move
      t.integer :winner
      t.boolean :resigned

      t.timestamps
    end
  end
end
