class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :mobail_number
      t.string :email
      t.string :date_of_birth
      t.string :activated, :default => "true"
      t.string :password_digest

      t.timestamps
    end
  end
end
