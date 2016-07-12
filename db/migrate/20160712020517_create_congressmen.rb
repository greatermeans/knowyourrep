class CreateCongressmen < ActiveRecord::Migration[5.0]
  def change
    create_table :congressmen do |t|
      t.string :name
      t.string :district
      t.string :city
      t.string :state
      t.string :email
      t.string :senate_or_house

      t.timestamps
    end
  end
end
