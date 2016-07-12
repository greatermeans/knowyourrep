class RemoveStuffFromCongressmen < ActiveRecord::Migration[5.0]
  def change
    remove_column :congressmen, :city, :string
    remove_column :congressmen, :name, :string
    add_column :congressmen, :first_name, :string
    add_column :congressmen, :last_name, :string
    add_column :congressmen, :party, :string
    add_column :congressmen, :religion, :string
    add_column :congressmen, :prior_experience, :string
    add_column :congressmen, :education, :string
    add_column :congressmen, :in_office_since, :integer
    add_column :congressmen, :birth_year, :integer
  end
end
