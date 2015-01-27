require 'spec_helper'

describe Article do

before(:each) do
    @article = Article.new
    @valid_attributes = { 
      :body => 'Big Money Ballers', 
      :author_emp_id => 5, 
      :title => "notes: this sponsor is ballin out of control!" }
  end

  it "should create a new instance given valid attributes" do
    @article.attributes = @valid_attributes
    @article.should be_valid
  end

#validation for presence of body
  it "validates presence of body" do
     article = Article.new(@valid_attributes.merge(:body => "dfghb"))
     article.should be_valid
  end

#validation for presence of author Emp Id
  it "validates presence of Author emp id" do
     article = Article.new(@valid_attributes.merge(:author_emp_id => 22))
     article.should be_valid
  end

#validation for presence of title
  it "validates presence of title" do
     article = Article.new(@valid_attributes.merge(:title => "dfghb"))
     article.should be_valid
  end


#association validation for has many comments
    it "should have many comments" do
      @article.should respond_to(:comments)
    end

#association validation for belongs to employee
it "should belong to a employee" do
    @article.attributes = @valid_attributes.except(:employee)
  @article.should have(0).error_on(:employee)
  end
end
