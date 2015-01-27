require 'spec_helper'

describe Holiday do

before(:each) do
    @holiday = Holiday.new
    @valid_attributes = { 
      :holiday_day => 'Monday', 
      :holiday_date  => "2013-5-22", 
      :holiday_type  => "holiday/Optional",
	:holiday_reason => "new year" }
  end

  it "should create a new instance given valid attributes" do
    @holiday.attributes = @valid_attributes
    @holiday.should be_valid
  end

#validation for presence of body
  it "validates presence of body" do
     holiday = Holiday.new(@valid_attributes.merge(:holiday_reason => "dfghb"))
     holiday.should be_valid
  end

end
