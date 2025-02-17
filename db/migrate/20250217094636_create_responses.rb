class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :request_id
      t.text :days

      t.timestamps
    end
  end
end
