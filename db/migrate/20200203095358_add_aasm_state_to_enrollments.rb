class AddAasmStateToEnrollments < ActiveRecord::Migration[6.0]
  def change
    add_column :enrollments, :aasm_state, :string
  end
end
