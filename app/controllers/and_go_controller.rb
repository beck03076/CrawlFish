class AndGoController < ApplicationController

  def index

	@and_go = AndGoLoginDetails.new

  end

  def create

	@user = AndGoLoginDetails.authenticate(params[:and_go_login_details])

	if @user

		session[:and_go_id] = @user.and_go_id
		session[:login_name] = @user.login_name
		redirect_to :controller => "and_go_dashboard", :action => "index"

	else

		@and_go = AndGoLoginDetails.new
		@message = "Invalid user name or password"
		render ('and_go/index')

	end

  end

  def destroy

    session[:and_go_id] = nil
    session[:login_name] = nil
    @message = "Logged out!"
    @and_go = AndGoLoginDetails.new
    render ('and_go/index')

  end

end
