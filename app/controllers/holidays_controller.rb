require 'date'
require 'will_paginate/array'
class HolidaysController < ApplicationController
  layout 'holiday'

before_filter :login_required
before_filter :find_logged_emp
before_filter :find_user_id

def index
    @holidays = Holiday.find(:all, :order =>'holiday_date Asc').paginate(:page => params[:page], :per_page => 10)
end

def new
    @holiday = Holiday.new
end

def create
    @holiday = Holiday.new(params[:holiday]) 
    @holiday.holiday_day = @holiday.holiday_date.strftime('%A')
     if @holiday.save
         redirect_to :action => 'index'
     else
         flash[:errors]="There was an error creating new holiday, #{@holiday.errors}"
         render :action => "new"
     end
end


 

 def edit
    @holiday = Holiday.find(params[:id])
  end
 
  def update
     @holiday = Holiday.find(params[:id])
     @holiday.update_attributes(params[:holiday])
     @holiday.holiday_day = @holiday.holiday_date.strftime('%A')
       if @holiday.update_attributes(params[:holiday])
          redirect_to :action => 'index'
       else
        flash[:errors]="There was an error updating holiday, #{@holiday.errors}"
        render :action => 'edit'
     end
  end

  def destroy
    @holiday = Holiday.find(params[:id])
    if @holiday.delete
       flash[:notice]="Selected holiday was successfully deleted!"
       redirect_to :action => 'index'
    end
  end


  def find_logged_emp
      @emp=current_emp
  end

  def find_user_id
      @uid=current_user_id
  end
   
  
 
end
