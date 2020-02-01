class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.float :price
      t.datetime :range_start_date
      t.datetime :range_end_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
