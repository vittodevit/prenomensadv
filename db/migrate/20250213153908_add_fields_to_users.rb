class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :approved_from_tutor, :boolean
  end
end
