require 'spec_helper'

describe User do
before(:each) do
    @user = User.new
        @valid_attributes = {
        :login => 'test',
        :hashed_password => 'efcom'
      }
    end

    it "should create a new instance given valid attributes" do
      @user.attributes = @valid_attributes
      @user.should be_valid
    end

#validation for presence of login 
  it "validates presence of login" do
     user = User.new(@valid_attributes.merge(:login => ""))
     user.should be_valid
  end

  
end
