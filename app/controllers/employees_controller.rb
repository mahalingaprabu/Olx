require 'will_paginate/array'
class EmployeesController < ApplicationController
include Utilities
layout 'employee'


before_filter :login_required
before_filter :find_logged_emp
before_filter :find_user_id

 def new
    @employee=Employee.new
    @user=User.new
	@employee.leaves.build
	
 end

 def index
     if @emp.is_admin?
     #@employees=Employee.all.paginate(:page => params[:page], :per_page => 5)
        @employees=Employee.search(params[:search]).paginate(:page => params[:page], :per_page => 5)
    # Rails.logger.info("hihello the employee id is: #{@employee.requester_emp_id}")
     else
     @my_reportees=@emp.reportees
     Rails.logger.info ("I have #{@my_reportees.count} number of reportees!!")
     @employees=Array.new
     @tmp = 0
     for i in 0..@my_reportees.count-1	
         @tmp=Employee.find(:all,:conditions =>['emp_id=?', @my_reportees[i].emp_id])
          for j in 0..@tmp.count-1
            @employees<<@tmp[j]
          end

end
@employees = @employees.paginate(:page => params[:page], :per_page => 5)  

end
    end

  def create
     @employee=Employee.new
     @user=User.new
     @user.login=params[:employee][:emp_id]
     @user.email=params[:employee][:off_email_id]
     @employee=Employee.new(params[:employee])
     params[:employee][:roles].delete("") 
     if !params[:employee][:roles].empty?
        tmproles=params[:employee][:roles]
     else
        tmproles=[].push(Role::None.id)
     end
     @employee.roles = Role.find_all(*tmproles.map(&:to_i))
     @employee.age=@employee.doj.year-@employee.dob.year
     @user.employee=@employee
     Rails.logger.info("The mob no is: #{@employee.mob_no}")

       if @employee.save && @user.save 

         flash[:notice] = "New employee with emp id: #{@employee.emp_id} was successfully created!"
         Notifications.welcome(@user).deliver
         redirect_to employee_path(@employee)
       else
          Rails.logger.info("The errors are: #{@employee.errors.full_messages}")
          flash[:errors]=(@employee.errors)
          #redirect_to new_employee_path
          render :action => "new"
      end
  end
 
 
  def leave_balances

        @leavecredit_sl = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "SL", :status => "Credit"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
	@leavedebit_sl = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "SL", 
             :status => "Approved"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})

	@leavecredit_cl = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "CL",
             :status => "Credit"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
	@leavedebit_cl = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "CL", 
             :status => "Approved"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})

	@leavecredit_el = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "EL", 
             :status => "Credit"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
	@leavedebit_el = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "EL", 
             :status => "Approved"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
 x = Time.now.year
 	 a= Date.new(x)
	
	 z = x + 1
	 b = Date.new(x).change(:year => z) -1
	@leavecredit_oh = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "OH", :status => "Credit", :start_date => a..b }, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
	 b = Date.new(x).change(:year => z) 
	

	@leavedebit_oh = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "OH", :status => "Approved", :start_date => a..b }, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
	
if @emp.emp_id != '0001' && @emp.emp_id != '0002' 

	if @leavecredit_sl == []&& @leavedebit_sl == []
	  @sickleavebal  = 0
        elsif @leavedebit_sl == []
	  @sickleavebal = @leavecredit_sl[0].no_of_days
	else
          @sickleavebal = @leavecredit_sl[0].no_of_days  - @leavedebit_sl[0].no_of_days
	end
	
	if@leavecredit_cl == []&& @leavedebit_cl == []
	  @casualleavebal  = 0
  	elsif @leavedebit_cl == []
          @casualleavebal = @leavecredit_cl[0].no_of_days
	else
          @casualleavebal = @leavecredit_cl[0].no_of_days - @leavedebit_cl[0].no_of_days
	end

	if@leavecredit_el == []&& @leavedebit_el == []
	  @earnedleavebal  = 0
  	elsif @leavedebit_el == []
	   @earnedleavebal = @leavecredit_el[0].no_of_days
	else
           @earnedleavebal = @leavecredit_el[0].no_of_days - @leavedebit_el[0].no_of_days
	end
	
      if@leavecredit_oh == [] && @leavedebit_oh == [] 
           @optionalholidaybal = 0
        elsif @leavedebit_oh == [] 
	   @optionalholidaybal = @leavecredit_oh[0].no_of_days 
	else
           @optionalholidaybal = @leavecredit_oh[0].no_of_days - @leavedebit_oh[0].no_of_days
	end

        @totalleavebal =  @sickleavebal + @casualleavebal + @earnedleavebal + @optionalholidaybal
else
  @sickleavebal = 0
 @casualleavebal = 0
  @earnedleavebal = 0
 @optionalholidaybal = 0
@totalleavebal = @sickleavebal + @casualleavebal + @earnedleavebal + @optionalholidaybal
  end
end


  def show
       @employee=Employee.find(params[:id])
       Rails.logger.info("This employees gender is :#{@employee.gender}")
       render :action => 'show', :layout => '/layouts/employee'
  end

     def emp_leave_status
     @employees=Employee.search(params[:search]).paginate(:page => params[:page], :per_page => 5)
     end

  def edit
     @employee=Employee.find(params[:id])
      @employee.leaves.where('admin_comments=?','Initial Credit').build
  end

  def update
     @employee=Employee.find(params[:id])
     
     params[:employee][:roles].delete("") 
     if !params[:employee][:roles].empty?
        tmproles=params[:employee][:roles]
     else
        tmproles=[].push(Role::None.id)
     end
     
     @a = Employee.where('emp_id=?', @employee.emp_id).pluck(:seperation_date)
if @a == [nil]
     @employee.update_attributes(params[:employee])
     @employee.roles = Role.find_all(*tmproles.map(&:to_i))
     @employee.age=@employee.doj.year-@employee.dob.year

     if @employee.save
         Rails.logger.info("The updated mob no is: #{@employee.mob_no}")
         flash[:notice] = "Employee with emp id: #{@employee.emp_id} was successfully updated!"
         redirect_to employee_path(@employee)
     else
         flash[:errors]=@employee.errors
         Rails.logger.info("The errors in update are: #{@employee.errors.each{|i,j| j}}")
         #redirect_to new_employee_path
         render :action => "edit"
     end
       else
         flash[:notice] = "Employee with emp id: #{@employee.emp_id} separated, you cann't edit"
         render :action => "edit"
end
 end


  def my_leave_approvals
    @my_reportees=@emp.reportees
     Rails.logger.info ("I have #{@my_reportees.count} number of reportees!!")
     @employees=Array.new
     @tmp = 0
     for i in 0..@my_reportees.count-1	
         @tmp=Employee.find(:all,:conditions =>['emp_id=?', @my_reportees[i].emp_id])
          for j in 0..@tmp.count-1
            @employees<<@tmp[j]
          end
     end
     @employees

    if Leave.search_leaves(params[:search])!= 'NULL'
	@leaves = []
 	for i in 0..@my_reportees.count-1
	@leave=Leave.search_leaves(params[:search]).where('status!=? AND status=? AND requester_emp_id=?', 'Credit','New', @my_reportees[i].emp_id).order('request_date desc')
 	 @leaves = @leaves+@leave
	end
    end
   @leaves = @leaves.paginate(:page => params[:page], :per_page => 5)    
end

def employee_separation
        @employees=Employee.search(params[:search]).paginate(:page => params[:page], :per_page => 5)
     #@employees=Employee.all.paginate(:page => params[:page], :per_page => 5)
    # Rails.logger.info("hihello the employee id is: #{@employee.requester_emp_id}")
end

 def anew
      @employee=Employee.find(params[:id])
end
def acreate
        @employee=Employee.find(params[:id])
	if  @employee.update_attributes(params[:employee])
          @eldays = @employee.encashed_days
	  @leaves = Leave.create(:start_date => Date.today, :end_date => Date.today, :requester_emp_id => @employee.emp_id, :leave_type => 'EL', :no_of_days =>@eldays, :status => 'Approved', :request_date => Date.today, :admin_comments => 'Employee Separated' )
	  @leaves.save
         flash[:notice] = "Employee with emp id: #{@employee.emp_id} was successfully Separated!"
      redirect_to employees_employee_separation_path
    end
end


  def team_leaves
     @my_reportees=@emp.reportees
     Rails.logger.info ("I have #{@my_reportees.count} number of reportees!!")
     @employees=Array.new
     @tmp = 0
     for i in 0..@my_reportees.count-1	
         @tmp=Employee.find(:all,:conditions =>['emp_id=?', @my_reportees[i].emp_id])
          for j in 0..@tmp.count-1
            @employees<<@tmp[j]
          end
     end
     @employees

    if Leave.search_leaves(params[:search])!= 'NULL'
	@leaves = []
 	for i in 0..@my_reportees.count-1
	@leave=Leave.search_leaves(params[:search]).where('status!=? AND status!=? AND requester_emp_id=?', 'Credit','New', @my_reportees[i].emp_id).order('request_date desc')
 	 @leaves = @leaves+@leave
	end
    end
   @leaves = @leaves.paginate(:page => params[:page], :per_page => 5)
end

  def my_leaves
     @leaves=Leave.where('requester_emp_id=? AND status!=?',current_emp.emp_id,"Credit" ).order('request_date desc').to_a.paginate(:page => params[:page], :per_page => 5)
  end

  def get_emp_manager_name
      emp_manager_emp_id=params[:id]
      #@manager=Employee.where("emp_id=?",emp_manager_emp_id)
      @manager = Employee.find_by_emp_id(emp_manager_emp_id)
      Rails.logger.info("The manager here is: #{@manager.last_name}")
      respond_to do |format|
         format.html
         format.json{ render :json => @manager }
      end
  end

   
  def find_logged_emp
      @emp=current_emp
      Rails.logger.info("Kani-This users emp id is: #{@emp.emp_id}")
  end

  def find_user_id
      @uid=current_user_id
  end
end     
