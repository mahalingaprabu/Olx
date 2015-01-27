class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :emp_id
      t.belongs_to :employee

      t.timestamps
    end
  end
end
