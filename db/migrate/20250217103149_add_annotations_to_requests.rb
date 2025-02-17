class AddAnnotationsToRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :requests, :annotations, :text
  end
end
