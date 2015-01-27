class ChangeArticles < ActiveRecord::Migration
  def up
     rename_column :articles, :emp_id, :author_emp_id
  end

  def down
     rename_column :articles, :author_emp_id, :emp_id
  end
end
