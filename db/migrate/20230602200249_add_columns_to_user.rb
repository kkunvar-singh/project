class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :otp, :string
    add_column :users, :otp_send_at, :datetime
  end
end
