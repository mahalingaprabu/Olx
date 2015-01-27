# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

 
 Employee.create(:first_name => "Human", :last_name => "Resource", :local_addr => "RAPIDTHINK Chennai", :perm_addr => "RAPIDTHINK, Chennai", :gender => "Male", :dob => '1980-01-01'.to_date, :doj => '2001-01-01'.to_date, :age => 30, :emp_id => "0001", :designation => 'Admin', :manager_emp_id => "0002", :manager_name => 'V.R.Vasudevan', :mob_no => 9876543212, :phone_no => 87654322, :pan_no => 'AXAXAXAXAX', :off_email_id => 'agentstream.agenta@gmail.com', :pers_email_id => 'admin@rapidthink.com', :roles => [Role::Admin])

 User.create(:login => "0001", :hashed_password =>  "1228ba4e731fbcd63a4ead9219a21bff94ddb377", :salt =>  "hj8SRBFroo", :email => 'agentstream.agenta@gmail.com', :employee_id => "0001" )

Leave.create(:requester_emp_id => "0001", :start_date => Date.today, :end_date => Date.today, :no_of_days => 0, :status => "Credit", :action_remarks => "Initial Credit",:request_date => Date.today, :admin_comments => "Annual Credit", :leave_type => "SL")
Leave.create(:requester_emp_id => "0001", :start_date => Date.today, :end_date => Date.today, :no_of_days => 0, :status => "Credit", :action_remarks => "Initial Credit",:request_date => Date.today, :admin_comments => "Annual Credit", :leave_type => "CL")
Leave.create(:requester_emp_id => "0001", :start_date => Date.today, :end_date => Date.today, :no_of_days => 0, :status => "Credit", :action_remarks => "Initial Credit",:request_date => Date.today, :admin_comments => "Annual Credit", :leave_type => "EL")




Employee.create(:first_name => "Vasudevan", :last_name => "V.R.", :local_addr => "RAPIDTHINK Chennai", :perm_addr => "RAPIDTHINK, Chennai", :gender => "Male", :dob => '1980-01-01'.to_date, :doj => '2001-01-01'.to_date, :age => 45, :emp_id => "0002", :designation => 'Managing Director', :manager_emp_id => "0001", :manager_name => 'Admin Admin', :mob_no => 9876543211, :phone_no => 87654321, :pan_no => 'AZAZAZAZAZ', :off_email_id => 'agentstream.tnss@gmail.com', :pers_email_id => 'vasu@rapidthink.com', :roles => [Role::Admin,Role::LeaveApprover])

 User.create(:login => "0002", :hashed_password => "345c8daff5fa1a313c8ab9bbd6acb6843af0e272", :salt => "61bebJMlwX", :email => 'agentstream.tnss@gmail.com', :employee_id => "0002" )
 
Leave.create(:requester_emp_id => "0002", :start_date => Date.today, :end_date => Date.today, :request_date => Date.today, :no_of_days => 0, :status => "Credit", :action_remarks => "Initial Credit", :admin_comments => "Annual Credit", :leave_type => "SL")
Leave.create(:requester_emp_id => "0002", :start_date => Date.today, :end_date => Date.today, :request_date => Date.today, :no_of_days => 0, :status => "Credit", :action_remarks => "Initial Credit", :admin_comments => "Annual Credit", :leave_type => "CL")
Leave.create(:requester_emp_id => "0002", :start_date => Date.today, :end_date => Date.today, :no_of_days => 0, :request_date => Date.today, :status => "Credit", :action_remarks => "Initial Credit", :admin_comments => "Annual Credit", :leave_type => "EL")




