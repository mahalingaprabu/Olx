class AddEncashedDaysToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :encashed_days, :integer
  end
end
