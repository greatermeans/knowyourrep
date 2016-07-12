class CreateSenateSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :senate_seats do |t|
      t.integer :politician_id
      t.integer :state_id
      t.integer :class
      t.integer :held_since
      t.integer :term_ends

      t.timestamps
    end
  end
end
