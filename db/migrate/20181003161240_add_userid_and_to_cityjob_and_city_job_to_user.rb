class AddUseridAndToCityjobAndCityJobToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cityjob_id, :integer
  end
end
