class AddUrlToCityjob < ActiveRecord::Migration[5.0]
  def change
    add_column :city_jobs, :url, :string
  end
end
