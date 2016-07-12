class CreateRepresentatives < ActiveRecord::Migration[5.0]
  def change
    create_table :representatives do |t|
      t.integer :politician_id
      t.integer :district_id
      t.integer :in_office_since
      t.integer :term_ends

      t.timestamps
    end
  end
end
