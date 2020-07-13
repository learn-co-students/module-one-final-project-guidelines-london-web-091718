class CreateJob < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :title
      # t.string :location
      t.boolean :full_time
      t.text :description
      t.string :company
      t.string :url
      t.timestamps
    end
  end
end
