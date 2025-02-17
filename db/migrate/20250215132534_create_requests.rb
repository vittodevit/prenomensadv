class CreateRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :requests do |t|
      t.date :due_date
      t.text :dates
      t.integer :user_id

      t.timestamps
    end
  end
end
