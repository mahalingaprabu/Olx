class AddSeperationDateToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :seperation_date, :date
  end
end
