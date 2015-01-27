require 'will_paginate/array'
class ArticlesController < ApplicationController
before_filter :login_required
before_filter :find_user_id
before_filter :find_logged_emp

layout 'article'

def new
    @article=Article.new
end

def index
    @articles=Article.all.paginate(:page => params[:page], :per_page => 10)
end

def create
    @article=Article.new(params[:article])
    @article.author_emp_id=@emp.emp_id
    @article.employee_id=@emp.id
    if @article.save
       flash[:notice]="Blog was saved successfully!"
       redirect_to :action => 'index'
    else

       flash[:errors]="Blog was not saved, #{@article.errors}"
       render :action => "new"
    end
end

def show
@article=Article.find(params[:id])
@comments = Comment.where('article_id =?', @article.id).order('id desc').to_a.paginate(:page => params[:page], :per_page => 5)
end

def aindex
end

def anew
@comment = Comment.new
@article=Article.find(params[:id])
@comments = Comment.where('article_id =?', @article.id).order('id desc').to_a.paginate(:page => params[:page], :per_page => 5)
@empname = @emp.first_name
end

def acreate
@article=Article.find(params[:id])
@comment = @article.comments.create(params[:data])
@comment.commenter_emp_id = @emp.emp_id
if @comment.save
 redirect_to :action =>'show'
end
end

def edit
   @article=Article.find(params[:id])
end

def update
    @article=Article.find(params[:id])
    @article.update_attributes(params[:article])
    if @article.save
       flash[:notice]="Blog was updated successfully!"
       redirect_to :action=>'show'
    else
       flash[:errors]="Blog could not be updated, #{@article.errors}"
       redirect_to :action=>'index'
    end
end

def destroy
    @article=Article.find(params[:id])
    if @article.destroy
       redirect_to :action=>'index'
    else
       flash[:errors]="There was an error deleting this blog post, #{@article.errors}"
       redirect_to :action=>'show'
    end
end


def save_comment
    #@article_id=params[:id]
    @article=Article.find(params[:id])
    @comment = Comment.new
    #@article.comments.create(params[:comment])
    @commentator = Employee.where('first_name=? AND last_name=?',params[:comment][:commentator_first_name],params[:comment][:commentator_last_name])[0]
    @comment.commenter_emp_id=@commentator.emp_id
    @comment.body=params[:comment][:body]
    @comment.article_id=params[:id]
    if @comment.save
        flash[:notice]="New comment was saved successfully!"
	redirect_to :action =>'show'
    else
        flash[:errors]="New comment could not be saved, please try again!, #{@comment.errors}"
        redirect_to :action => 'anew'
    end
end

def find_user_id
    @uid=current_user_id
end

def find_logged_emp
    @emp=current_emp
end

 
end
