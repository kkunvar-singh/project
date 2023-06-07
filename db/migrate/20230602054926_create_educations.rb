class CreateEducations < ActiveRecord::Migration[7.0]
  def change
    create_table :educations do |t|
      t.string :institude_name
      t.string :university
      t.string :course
      t.string :stream
      t.string :marks
      t.string :passed_year
      t.integer :parsentage

      t.timestamps
    end
  end
end
