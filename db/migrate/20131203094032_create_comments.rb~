class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :article
      t.string :commenter_emp_id
      t.text :body

      t.timestamps
    end
  end
end
