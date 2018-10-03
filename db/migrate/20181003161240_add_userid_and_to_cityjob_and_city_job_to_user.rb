class AddUseridAndToCityjobAndCityJobToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :user, :cityjob_id, :integer
  end
end
