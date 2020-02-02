class AddRoomReferencesToSearches < ActiveRecord::Migration[6.0]
  def change
    add_reference :searches, :room, null: false, foreign_key: true
  end
end
