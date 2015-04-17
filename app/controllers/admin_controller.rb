class AdminController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize current_user, :edit?
    @users = policy_scope(User)
  end

  def new
    authorize current_user, :edit?
  	@user = User.new(:name => params[:user][:name], :email => params[:user][:email], :role => params[:user][:role], :password => 'password')
  	@user.save!
    @users = User.all
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.js { render 'render_table.js.haml'} 
    end
  end

  def destroy
    authorize current_user, :edit?
  	@user = User.find(params[:user])
  	@user.destroy
    @users = User.all
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.js { render 'render_table.js.haml'} 
    end
  end

  def reset_salesforce
    authorize current_user, :edit?
  end

  def save_password
    authorize current_user, :edit?
    #@old_password = params[:old_password][:old_password]
    @password = params[:password][:password]
    @confirm_password = params[:confirm_password][:confirm_password]
    @security_token = params[:token][:token]
    #@confirm_security_token = params[:confirm_token][:confirm_token]
    if @password == @confirm_password
      ENV['SALESFORCE_PASSWORD'] = @password
      ENV['SALESFORCE_SECURITY_TOKEN'] = @security_token
      flash[:notice] = "Salesforce password successfully updated."
    end
    redirect_to root_path
  end
end
