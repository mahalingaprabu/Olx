class RenameActionAddActionDateToLeaves < ActiveRecord::Migration
  def up
      add_column :leaves, :action_date, :date
      rename_column :leaves, :action, :status
  end

  def down
     remove_column :leaves, :action_date
     rename_column :leaves, :status, :action
  end
end
