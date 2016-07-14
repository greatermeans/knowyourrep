class RemoveStateIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :state_id
  end
end
