class RenameRepresentativesToRepresentativeSeats < ActiveRecord::Migration[5.0]
  def change
    rename_table :representatives, :representative_seats
  end
end
