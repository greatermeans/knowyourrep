class RemoveClassFromSenateSeats < ActiveRecord::Migration[5.0]
  def change
    remove_column :senate_seats, :class, :integer
    add_column :senate_seats, :class_num, :integer
  end
end
