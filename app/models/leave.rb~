class Leave < ActiveRecord::Base
  attr_accessible :action_remarks, :admin_comments, :approver_emp_id, :end_date, :ref_id, :leave_type, :no_of_days,
  :requester_emp_id, :start_date, :status, :request_remarks, :request_date, :status

validate :end_date_grt_than_start_date, :if => Proc.new{|a| a.status=="New"}
validates_presence_of :requester_emp_id
validates_presence_of :leave_type
validates_presence_of :start_date, :end_date, :no_of_days
validates_presence_of :status
validates_presence_of :request_remarks, :if => Proc.new{ |a| a.status=="New" }, :message => "Please input request remarks"



#validates_numericality_of :requester_emp_id, :only_integer => true, :message => "Please input a valid entry for requester emp id"
#validates_numericality_of :approver_emp_id, :only_integer => true, :message => "Please enter a whole number for approver emp id"
validates_numericality_of :no_of_days, :only_integer => true, :message => "Please enter a whole no for no. of days of leave"
validates_date :start_date, :end_date

belongs_to :employee, :class_name => 'Employee', :foreign_key => 'employee_id'

def self.search_leaves(search)
   if search
	search = search.split(' ').first
	search = Employee.where('first_name =?',search).pluck(:emp_id) 
       where('ref_id LIKE? or requester_emp_id LIKE?', "%#{search}%", "%#{search}%")
       #ActiveRecord::Base.logger.info("Ticket: #{s.to_s}")
    
   else
       scoped
   end
end



def is_new?
   self.status=='New'
end

def is_actioned?
    self.status!='New'
end

def end_date_grt_than_start_date
     errors.add(:start_date,"Leave end date should be greater than or equal to Leave start date") if 
     (!no_of_days.blank? and no_of_days <= 0) 
end



end
