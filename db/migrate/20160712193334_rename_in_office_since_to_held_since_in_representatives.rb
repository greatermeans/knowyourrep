class RenameInOfficeSinceToHeldSinceInRepresentatives < ActiveRecord::Migration[5.0]
  def change
    rename_column :representatives, :in_office_since, :held_since
  end
end
