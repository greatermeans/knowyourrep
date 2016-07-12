class RemoveStateFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :state, :string
    add_column :users, :state_id, :integer
  end
end
