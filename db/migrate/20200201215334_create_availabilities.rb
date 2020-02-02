class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.datetime :start
      t.datetime :end
      t.boolean :is_available, default: true

      t.timestamps
    end
  end
end
