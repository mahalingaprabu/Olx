class Article < ActiveRecord::Base
  attr_accessible :body, :author_emp_id, :title

validates_presence_of :title, :message => "title cannot be blank"
  validates_presence_of :body, :message => "body cannot be blank"
  validates_uniqueness_of :title, :message => "title should be unique"

  belongs_to :employee, :class_name => "Employee"
  has_many :comments, :dependent => :destroy

end
