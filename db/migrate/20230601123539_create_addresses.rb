class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :parmanent_address
      t.string :residencial_address
      t.string :city
      t.string :state
      t.string :country
      t.string :pin
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
