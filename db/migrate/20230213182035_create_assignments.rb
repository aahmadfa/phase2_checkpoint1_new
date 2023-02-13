class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.integer :store_id
      t.integer :employee_id
      t.integer :start_date
      t.integer :end_date

      t.timestamps
    end
  end
end
