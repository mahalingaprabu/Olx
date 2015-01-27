require 'will_paginate/array'
class LeaveCreditsController < ApplicationController
before_filter :login_required
before_filter :find_user_id
before_filter :find_logged_emp
before_filter :find_rt_emp_info
layout 'leave'

def quarterly_credits

$lastQCD = Leave.where("admin_comments=? or status=?",'auto lapsed','Credit').pluck(:start_date).last


 @rt_employees = Employee.all
    @emp_count = @rt_employees.count
    d = 0 
    $s=Array.new
    for i in 1..@emp_count
      @a = Employee.where('id=?', i).pluck(:seperation_date)
      @b = Employee.where('id=?', i).pluck(:emp_id)
     if @a == [nil]
      $s << @b
      $d = d+1
     end
end
end


def rt_qlc
    for i in 0..@emp_count-1
      @employee = @rt_employees[i]
      @qlc = Leave.new(params[:qlc])
      @qlc.status = "Credit"
   
      @qlc.requester_emp_id = @employee.emp_id
     	emp_presence =  $s.include?([@employee.emp_id])
	if emp_presence == true && @employee.emp_id != '0001' && @employee.emp_id != '0002'
      if @qlc.save

        flash[:notice] = "Quarterly leave credited successfully for #{$s.count-2} employees "
      else
        flash[:errors] = "There was a problem crediting quarterly leaves, #{@qlc.errors}"
      end
 	end
    end

    redirect_to :action => 'show'
end


def annual_credits
$lastACD = Leave.where('admin_comments=?','Annual Credit').pluck(:start_date).last.year
 @rt_employees = Employee.all
    @emp_count = @rt_employees.count
    d = 0 
    $s=Array.new
    for i in 1..@emp_count
      @a = Employee.where('id=?', i).pluck(:seperation_date)
      @b = Employee.where('id=?', i).pluck(:emp_id)
     if @a == [nil]
      $s << @b
      $d = d+1
     end
end
end


def rt_alc
   for j in 1..3       
     for k in 0..@emp_count-1
         @employee = @rt_employees[k]
         @alc = Leave.new(params[:alc])
         @alc.status = "Credit"
	@alc.admin_comments = "auto lapsed"
         @alc.requester_emp_id = @employee.emp_id

        if j == 1
        @leavecredit_sl = Leave.find(:all, :conditions => {:requester_emp_id => @employee.emp_id, :leave_type => "SL", :status => "Credit"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @employee.emp_id})
	@leavedebit_sl = Leave.find(:all, :conditions => {:requester_emp_id => @employee.emp_id, :leave_type => "SL", :status => "Approved"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @employee.emp_id})

		if @leavecredit_sl == []&& @leavedebit_sl == []
		  @sickleavebal = 0
	        elsif @leavedebit_sl == []
		  @sickleavebal = @leavecredit_sl[0].no_of_days
		else
	          @sickleavebal = @leavecredit_sl[0].no_of_days  - @leavedebit_sl[0].no_of_days
		end
	              @alc.leave_type = "SL"
	              @alc.no_of_days = -@sickleavebal

        elsif j == 2 
	@leavecredit_cl = Leave.find(:all, :conditions => {:requester_emp_id => @employee.emp_id, :leave_type => "CL", :status => "Credit"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @employee.emp_id})
	@leavedebit_cl = Leave.find(:all, :conditions => {:requester_emp_id => @employee.emp_id, :leave_type => "CL", :status => "Approved"}, :select => "SUM(no_of_days) AS no_of_days", :group => { :requester_emp_id => @employee.emp_id})
		if @leavecredit_cl == []&& @leavedebit_cl == []
		  @casualleavebal  = 0
  		elsif @leavedebit_cl == []
        	  @casualleavebal = @leavecredit_cl[0].no_of_days
		else
        	  @casualleavebal = @leavecredit_cl[0].no_of_days - @leavedebit_cl[0].no_of_days
		end
              @alc.leave_type = "CL"
              @alc.no_of_days = -@casualleavebal
	
	 elsif j == 3
	z = Array.new
        @ellapse_start_date = Leave.find(:all, :conditions => {:requester_emp_id => @employee.emp_id, :leave_type => "EL", :admin_comments => "Annual Credit"}, :select => :start_date)

	 c = @ellapse_start_date.count 
	for t in 0..c-1
 	  z[t] = @ellapse_start_date[t].start_date
	end
 	z.sort!
 	a = z.last 
	z = z.clear
         b = Date.today

	@elcredit_days = Leave.find(:all, :conditions => {:requester_emp_id =>@employee.emp_id, :leave_type => "EL", :status => "Credit", :start_date => a..b}, :select => "SUM(no_of_days) AS no_of_days",:order => "start_date ASC")
	@elcredit_days = @elcredit_days[0].no_of_days
	

        @elapproved_days = Leave.find(:all, :conditions => {:requester_emp_id =>@employee.emp_id, :leave_type => "EL", :status => "Approved",:start_date => a..b}, :select => "SUM(no_of_days) AS no_of_days",:order => "start_date ASC")
        @elapproved_days = @elapproved_days[0].no_of_days

	if @elapproved_days == nil
	@elapproved_days = 0
	end

	@current_year_lb = @elcredit_days-@elapproved_days
	if @current_year_lb > 5
	@alc.leave_type = "EL"
        @alc.no_of_days = -(@current_year_lb - 5) 
	else
	@alc.leave_type = "EL"
        @alc.no_of_days = 0
	end

   end
     	@emp_presence =  $s.include?([@employee.emp_id])
	if @emp_presence == true && @employee.emp_id != '0001' && @employee.emp_id != '0002'
	if @alc.save
        else
            flash[:errors] = "There was a problem crediting annual leaves, #{@alc.errors}"
        end
	end
   end

     for i in 0..@emp_count-1
         @rtemployees = Employee.all
         @empl = @rtemployees[i]
         @alc = Leave.new(params[:alc])
         @alc.status = "Credit"
         @alc.admin_comments = "Annual Credit"
         @alc.requester_emp_id = @empl.emp_id
        
	 if j == 1
              @alc.leave_type = "SL"
              @alc.no_of_days = 6
         elsif j == 2 
              @alc.leave_type = "CL"
              @alc.no_of_days = 6
   
	elsif j == 3
              @alc.leave_type = "EL"
              @alc.no_of_days = 3      

        end

    
     	@emp_presence =  $s.include?([@empl.emp_id])
	if @emp_presence == true && @empl.emp_id != '0001' && @empl.emp_id != '0002'
          if @alc.save
            flash[:notice] = "Annual Leave credited successfully for #{$s.count-2}employees "
          else
            flash[:errors] = "There was a problem crediting annual leaves, #{@alc.errors}"
          end
	end
   end 

end
    redirect_to :action => 'show'
end
def ohindex
@allowed_oh = Leave.new
@allowedohs = Leave.where('request_remarks =?',"O/H credit").order('start_date desc').paginate(:page => params[:page], :per_page => 3)
end

def ohnew
@allowed_oh = Leave.new
end

def ohcreate
@rtemployees = Employee.all
@rtemployee = @rtemployees.count

@allowed_oh = Leave.new(params[:leave_oh])
for i in 0..@rtemployee-1
@empl = @rtemployees[i]
@allowed_oh.end_date = @allowed_oh.end_date
@allowed_oh.requester_emp_id = @empl.emp_id
@allowed_oh.save
end
redirect_to :action => 'ohindex'
end


def ohedit
@allowed_oh = Leave.find(params[:id])
end

def ohupdate
@allowed_oh = Leave.find(params[:id])
if @allowed_oh.update_attributes(params[:allowed_oh])
redirect_to :action => 'ohindex'
flash[:notice] = "optional Leave alloted successfully "
else
render :action => 'ohedit'
end
end

def show
 @e = Employee.find(:all, :conditions => {:seperation_date => nil}, :select =>:emp_id)
@c = @e.count
@beforecredit = Leave.where("admin_comments=? or status=?",'auto lapsed','Credit').pluck(:created_at).last
end


def find_rt_emp_info
    @rt_employees = Employee.all
    @emp_count = @rt_employees.count
    d = 0 
    s=Array.new
    for i in 1..10
      @a = Employee.where('id=?', i).pluck(:seperation_date)
      @b = Employee.where('id=?', i).pluck(:emp_id)
     if @a == [nil]
      s << @b
      d= d+1
     end
  end

	
end


def find_user_id
    @uid=current_user_id
end


def find_logged_emp
    @emp=current_emp
end


end
