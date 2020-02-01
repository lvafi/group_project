class AddFeatureReferencesToSearches < ActiveRecord::Migration[6.0]
  def change
    add_reference :searches, :feature, null: false, foreign_key: true
  end
end
