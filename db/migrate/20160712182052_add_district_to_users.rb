class AddDistrictToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :district_id, :integer
  end
end
