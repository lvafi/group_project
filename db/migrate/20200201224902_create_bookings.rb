class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :course, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.boolean :status, :default => false 
      t.datetime :time_slot
      t.timestamps
    end
  end
end
