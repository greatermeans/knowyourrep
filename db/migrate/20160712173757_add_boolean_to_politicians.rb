class AddBooleanToPoliticians < ActiveRecord::Migration[5.0]
  def change
    add_column :politicians, :in_office?, :boolean, default: false
  end
end
