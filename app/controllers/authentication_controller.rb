class AuthenticationController < ApplicationController
layout 'authentication'

before_filter :find_logged_emp, :only => 'reset_password'
before_filter :find_user_id, :only => 'reset_password'


    def login
         @user=User.new
         if !request.post?
            return
         else
           if !params[:user][:login].empty? && !params[:user][:password].empty? 
		if @user.hashed_password == []
                  flash[:notice]="Your password is not set, please set it to use OLS"
                else
 			if session[:user]=User.authenticate(params[:user][:login],params[:user][:password]) 
  		
             		@user=session[:user]
			@a = Employee.where('emp_id=?', @user.login).pluck(:seperation_date)
			if @a == [nil]
               		   redirect_to leave_balances_employee_path(@user.id)
			else
                          redirect_to :action => 'login'
                        end

               		else 
             		  flash[:notice]="Login was unsuccessful, username or password was incorrect. please try again!"
                         redirect_to :action => 'login'
                        end
                end
           else
               flash[:notice]="Please enter values for both Username and Password!"
               redirect_to :action => 'login'
           end

	end
     end

    def logout
        session[:user]=nil
        reset_session
        flash[:notice]="You have been logged out successfully"
      #  Rails.logger.info("The flash notice now is: #{flash[:notice]}")
        redirect_to :action => 'login'
    end


   def set_password
        @user=User.find(params[:id])
        if request.post?
          Rails.logger.info("Current user is: #{@user.login}")
          if !params[:user][:password].empty? && !params[:user][:password_confirmation].empty?
           if(params[:user][:password] == params[:user][:password_confirmation])
             @user.password=params[:user][:password]
              if @user.save
                 flash[:notice]="Your password has been set"
                 session[:user]=User.authenticate(@user.login,params[:user][:password_confirmation])
                  redirect_to leave_balances_employee_path(@user.id)
              else
                 flash[:notice]=@user.errors
              end
           else
                 flash[:notice]="Password and Password Confirmation do not match, please try again!"
                 render 'set_password'
           end
          else
               flash[:notice]="Please enter values for both Password and Password Confirmation!"
               render :action => 'set_password'
          end
        end
     end


   def reset_password
       if request.post?
          if session[:user]==User.authenticate(params[:user][:login],params[:user][:password])
            @user=session[:user]
            @emp=@user.employee
            Rails.logger.info("The emps name is: #{@emp.first_name}")
             if params[:user][:new_password]==params[:user][:new_password_confirmation]
                   @user.password=params[:user][:new_password]
                   if @user.save
                      flash[:notice]="Your password has been updated"
                      session[:user]=User.authenticate(@user.login,params[:user][:new_password])
                   else
                      flash[:notice]=@user.errors
                   end
              else
                   flash[:notice]="New Password and Confirmation do not match, please try again!"
              end
           else
              flash[:notice]="Entered credentials dont match logged in user, please try again!"
           end
       end
       Rails.logger.info("The errors in reset pwd are: #{flash[:errors]}")
       render :layout => 'employee'
  end



   def forgot_password
       if request.post?
          u=User.find_by_login(params[:user][:login])
          if u && u.send_new_password
             flash[:notice]="A new password has been sent to your email"
             redirect_to :action => 'login'
          else
             flash[:notice]="Could not send password"
          end
       end
   end

  def find_logged_emp
      @emp=current_emp
  end

  def find_user_id
      @uid=current_user_id
  end

end
