require 'spec_helper'

describe Leave do

before(:each) do
    @leave = Leave.new
    @valid_attributes = { 
    :action_remarks => "new action",
    :admin_comments => "new comment",
    :approver_emp_id => 32,
    :end_date  => "2013-6-4",
    :ref_id => 2,
    :leave_type  => "optional/holiday",
    :no_of_days  => 7,
    :request_remarks => "remarks",
    :requester_emp_id => 8,
    :start_date => "2013-5-3",
    :status => "new",
    :request_remarks => "ygiagdu",
    :request_date => "2013-8-7" }
  end

  it "should create a new instance given valid attributes" do
    @leave.attributes = @valid_attributes
    @leave.should be_valid
  end

#validation for presence of requester_emp_id
  it "validates presence of body" do
     leave = Leave.new(@valid_attributes.merge(:requester_emp_id => 8))
     leave.should be_valid
  end

#validation for presence of leavetype
  it "validates presence of leave type" do
     leave = Leave.new(@valid_attributes.merge(:leave_type  => "optional/holiday"))
     leave.should be_valid
  end

#validation for presence of status
  it "validates presence of status" do
     leave = Leave.new(@valid_attributes.merge(:status => "new"))
     leave.should be_valid
  end

#validation for presence of start date
  it "validates presence of start date" do
     leave = Leave.new(@valid_attributes.merge(:start_date => "2013-6-7"))
     leave.should be_valid
  end

#validation for presence of end date
  it "validates presence of End date" do
     leave = Leave.new(@valid_attributes.merge(:end_date => "2013-6-7"))
     leave.should be_valid
  end
#validation for presence of no of days
  it "validates presence of no of days" do
     leave = Leave.new(@valid_attributes.merge(:no_of_days => 6))
     leave.should be_valid
  end

# validation for no_of_days numericality
 it "validates numericality of no_of_days" do
    @leave.attributes = @valid_attributes
    @leave.no_of_days = 'abc'
    @leave.should have(1).error_on(:no_of_days) 
  end
end
