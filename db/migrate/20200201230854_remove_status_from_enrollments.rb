class RemoveStatusFromEnrollments < ActiveRecord::Migration[6.0]
  def change

    remove_column :enrollments, :status, :string
  end
end
