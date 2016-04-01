class GroupsController < ApplicationController
  
  before_filter :ensure_sign_in
  include SalesforceClient

  def new
  #   # Set filter values for _filter partial
    @filter_values = get_filter_values
  end
  
  def index
  	@groups = Group.where(:user => current_user)
  	return
  end
end
