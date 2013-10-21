class SessionController < ApplicationController

  def new
  end

  def create
    @user = User.where(email: params[:email]).first
    if @user
      if @user.authenticate params[:password]
        flash[:notice] = "You have successfully logged in #{@user.email}! "
        session[:user_id] = @user.id
        redirect_to @user
      else
        flash[:error] = "Unfortunately you typed in the wrong password..."
        render :new
      end
    else
      flash[:error] = "Unfortunately, the email #{params[:email]} does not exist"
      render :new
    end
  end

  def destroy
    flash[:notice] = "You have successfully logged out."
    session[:user_id] = nil
    redirect_to '/'
  end

end
