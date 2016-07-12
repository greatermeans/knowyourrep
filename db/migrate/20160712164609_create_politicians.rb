class CreatePoliticians < ActiveRecord::Migration[5.0]
  def change
    create_table :politicians do |t|
      t.string :first_name
      t.string :last_name
      t.string :party
      t.string :religion
      t.string :prior_experience
      t.string :education
      t.integer :birth_year
      t.string :email
      t.integer :state_id

      t.timestamps
    end
  end
end
