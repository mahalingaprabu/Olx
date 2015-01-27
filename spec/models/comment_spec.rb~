require 'spec_helper'

describe Comment do
before(:each) do
    @comment = Comment.new
    @valid_attributes = { 
      :body => 'Big Money Ballers', 
      :article_id => 5, 
      :commenter_emp_id => 1}
  end

  it "should create a new instance given valid attributes" do
    @comment.attributes = @valid_attributes
    @comment.should be_valid
  end

#validation for presence of body
  it "validates presence of body" do
     comment = Comment.new(@valid_attributes.merge(:body => "dfghb"))
     comment.should be_valid
  end

#association validation for belongs to article
it "should belong to a article" do
    @comment.attributes = @valid_attributes.except(:article)
  @comment.should have(0).error_on(:article)
  end

end
