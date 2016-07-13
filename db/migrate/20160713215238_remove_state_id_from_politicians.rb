class RemoveStateIdFromPoliticians < ActiveRecord::Migration[5.0]
  def change
  	remove_column :politicians, :state_id, :integer
  end
end
