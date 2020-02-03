class AddRoomReferencesToAvailabilities < ActiveRecord::Migration[6.0]
  def change
    add_reference :availabilities, :room, null: false, foreign_key: true
  end
end
