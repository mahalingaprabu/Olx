require 'will_paginate/array'
class LeavesController < ApplicationController
before_filter :login_required
before_filter :find_user_id
before_filter :find_logged_emp

layout 'leave'

def new
 @leave=Leave.new
 Rails.logger.info("First name of current user is: #{@emp.first_name}")
end

def create
 @leave=Leave.new(params[:leave])
 @leave.end_date = @leave.end_date.strftime("%d-%b-%Y")
 @leave.start_date = @leave.start_date.strftime("%d-%b-%Y")
 @leave.no_of_days = (@leave.end_date - @leave.start_date).to_i + 1
 
 @holiday_date = Holiday.find(:all, :conditions => {:holiday_type =>"Holiday"}, :select => :holiday_date)

@optional_holiday_date = Holiday.find(:all, :conditions => {:holiday_type => "Optional Holiday"}, :select=>:holiday_date)
      Rails.logger.info("The enddate Debit is: #{@leave.end_date}")
      Rails.logger.info("The startdate Debit is: #{@leave.start_date}")
  y = x = 0
    s = Array.new
    t = Array.new
    k = @leave.no_of_days
    i =  @holiday_date.count
    m =  @optional_holiday_date.count
    a = @leave.start_date
    b = @leave.end_date
   for j in 1..k            # if Holiday present no_of_days count should not to be considered
      for h in 0...i
        s[h] = @holiday_date[h].holiday_date
          if a == s[h] 
            x = x + 1 
	  end
      end

      for n in 0...m
          t[n] =  @optional_holiday_date[n].holiday_date
	if a == t[n] 
            y = y + 1
         oh_date = t[n]  
	  end
 	end
 
      if a.strftime("%a") == "Sun"        # if sunday no_of_days count should not to be considered
         x = x + 1 
      end
      if a.strftime("%a") == "Sat"        # if saturday no_of_days count should not to be considered
         x = x + 1
      end 
      a = a + 1
   end

 @leave.no_of_days = @leave.no_of_days - x - y    # x the no of "holiday, optional holiday, sunday and saturday" count
 @leave.requester_emp_id=@emp.emp_id
 @leave.employee_id=@emp.id
 lt=params[:leave][:leave_type]
 lref_id=@leave.ref_id=("LR" + lt.to_s + rand(10 ** 10).to_s.rjust(10,'0')).to_s
 @leave.approver_emp_id=@emp.find_leave_approver.emp_id

	
   if @leave.leave_type == "SL" # if sick leave balance is zero, user cannt apply sick leave
      @leavecredit_sl = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "SL", :status => "Credit"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
      Rails.logger.info("The SL Credit is: #{@leavecredit_sl}")
      @leavedebit_sl = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "SL", :status => "Approved"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
      Rails.logger.info("The SL Debit is: #{@leavedebit_sl}")
    if @leavedebit_sl == []
     @sickleavebal = @leavecredit_sl[0].no_of_days
   else
    @sickleavebal = @leavecredit_sl[0].no_of_days  - @leavedebit_sl[0].no_of_days
   end
      if @sickleavebal == 0 || (@sickleavebal - @leave.no_of_days) < 0
        flash[:notice]="You don't have enough Sick Leave balance to apply"
        render :action => "new"
      else
        if @leave.save
         Notifications.leavereq(@emp).deliver
          flash[:notice]="Leave request #{lref_id} was submitted successfully!"
        else
       flash[:errors]="Leave request action was not successful, #{@leave.errors}"
        end
        redirect_to :action => 'new'
      end
   elsif @leave.leave_type == "CL" # if casual leave balance is zero, user cannt apply casual leave
      @leavecredit_cl = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "CL", :status => "Credit"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
@leavedebit_cl = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "CL", :status => "Approved"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
	if @leavedebit_cl == []
 	  @casualleavebal = @leavecredit_cl[0].no_of_days
	else
      @casualleavebal = @leavecredit_cl[0].no_of_days - @leavedebit_cl[0].no_of_days
	end
      if @casualleave == 0 || (@casualleavebal - @leave.no_of_days) < 0
        flash[:notice]="You don't have enough Casual Leave balance to apply"
        render :action => "new"
      else
        if @leave.save
         Notifications.leavereq(@emp).deliver
          flash[:notice]="Leave request #{lref_id} was submitted successfully!"
        else
       flash[:errors]="Leave request action was not successful, #{@leave.errors}"
        end
        redirect_to :action => 'new'
      end
   elsif @leave.leave_type == "OH" # if optional leave balance is zero, user cannt apply optional leave
   x = Time.now.year
 	 a= Date.new(x)
	
	 z = x + 1
	 b = Date.new(x).change(:year => z) -1
	@leavecredit_oh = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "OH", :status => "Credit", :start_date => a..b }, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
	
	 b = Date.new(x).change(:year => z) 
	@leavedebit_oh = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "OH", :status => "Approved", :start_date => a..b }, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
		
	if @leavecredit_oh == [] && @leavedebit_oh == [] 
           @optionalholidaybal = 0
        elsif @leavedebit_oh == [] 
	   @optionalholidaybal = @leavecredit_oh[0].no_of_days
	else
        @optionalholidaybal = @leavecredit_oh[0].no_of_days - @leavedebit_oh[0].no_of_days
	end
        if @optionalholidaybal == 0 || (@optionalholidaybal - @leave.no_of_days) < 0
        flash[:notice]="You don't have enough Optional Holidays to apply"
        render :action => "new"
      else
      Rails.logger.info("The opt leave: #{y}")
        if y > 0
 @leave.no_of_days = y  

      Rails.logger.info("The enddate Debit is: #{@leave.end_date}")
     Rails.logger.info("The enddate Debit is: #{@leave.start_date}")
        if @leave.save
         Notifications.leavereq(@emp).deliver
          flash[:notice]="Leave request #{lref_id} was submitted successfully!"
        else
          flash[:notice]="Request_remarks not to be blank"
        end
	else
           flash[:notice]="Hi The date you are entered is not an optional holiday"
       end
        redirect_to :action => 'new'
   
      end
   elsif @leave.leave_type == "EL" # if earned leave balance is zero, user cannt apply earned leave
      @leavecredit_el = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "EL", :status => "Credit"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
@leavedebit_el = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "EL", :status => "Approved"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
	if @leavedebit_el == []
      @earnedleavebal = @leavecredit_el[0].no_of_days
	else
      @earnedleavebal = @leavecredit_el[0].no_of_days - @leavedebit_el[0].no_of_days
	end
      if @earnedleavebal == 0 || (@earnedleavebal - @leave.no_of_days) < 0
        flash[:notice]="Hi You don't have enough Earned leave to apply"
        render :action => "new"
      else
        if @leave.save
         Notifications.leavereq(@emp).deliver
          flash[:notice]="Leave request #{lref_id} was submitted successfully!"
        else
       flash[:errors]="Leave request action was not successful, #{@leave.errors}"
        end
        redirect_to :action => 'new'
      end
   end

if y > 0 && @leave.leave_type != "OH"
	 @opt_leave = Leave.new
	 @opt_leave.end_date = oh_date.strftime("%d-%b-%Y")
         @opt_leave.start_date = oh_date.strftime("%d-%b-%Y")
         @opt_leave.requester_emp_id=@emp.emp_id
         @opt_leave.employee_id=@emp.id
	 @opt_leave.no_of_days = y
	 @opt_leave.leave_type= "OH"
	 @opt_leave.request_date = Date.today
	 @opt_leave.request_remarks = @leave.request_remarks
         lref_id=@opt_leave.ref_id=("LR" + lt.to_s + rand(10 ** 10).to_s.rjust(10,'0')).to_s
         @opt_leave.approver_emp_id=@emp.find_leave_approver.emp_id
         @opt_leave.status = 'New'
          x = Time.now.year
 	 a= Date.new(x)
	
	 z = x + 1
	 b = Date.new(x).change(:year => z) -1
	@leavecredit_oh = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "OH", :status => "Credit", :start_date => a..b }, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
@leavedebit_oh = Leave.find(:all, :conditions => {:requester_emp_id => @emp.emp_id, :leave_type => "OH", :status => "Approved"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @emp.emp_id})
   	  if @leavecredit_oh == [] && @leavedebit_oh == [] 
            @optionalholidaybal = 0
          elsif @leavedebit_oh == [] 
	    @optionalholidaybal = @leavecredit_oh[0].no_of_days
     	  else
            @optionalholidaybal = @leavecredit_oh[0].no_of_days - @leavedebit_oh[0].no_of_days
   	  end
      
  	  if @optionalholidaybal == 0 
             flash[:notice]="You don't have enough Optional Holidays to apply"
          else
      Rails.logger.info("The enddate Debit is: #{@opt_leave.end_date}")
      Rails.logger.info("The enddate Debit is: #{@opt_leave.start_date}")
             if @opt_leave.save
         Notifications.leavereq(@emp).deliver
              flash[:notice]="Leave request #{lref_id} was submitted successfully!"
             else
       flash[:errors]="Leave request action was not successful, #{@leave.errors}"
             end
	  end
	end
 


end

def edit
    @leave=Leave.find(params[:id]) 

end

def update
    @leave=Leave.find(params[:id]) 
    @leave.action_date = Time.now
       if @leave.update_attributes(params[:leave])
          redirect_to :action => 'request_details'
       flash[:notice]="Leave request changed successfully"
       else
        render :action => 'edit'
     end
end

def request_details
    @leave=Leave.find(params[:id])
end


def action_leave
    @leave=Leave.find(params[:leave][:id])
    @leave.status=params[:leave][:status]
    @leave.action_remarks=params[:leave][:action_remarks]
    @leave.action_date=params[:leave][:action_date]
    if @leave.save
       flash[:notice]="Leave request actioned successfully"
    else
       flash[:errors]="Leave request action was not successful, #{@leave.errors}"
    end
       redirect_to :action => 'request_details'
end




def find_user_id
    @uid=current_user_id
end


    
def find_logged_emp
    @emp=current_emp
end

end
