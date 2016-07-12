class RemoveReligionFromPolitician < ActiveRecord::Migration[5.0]
  def change
    remove_column :politicians, :religion, :string
  end
end
