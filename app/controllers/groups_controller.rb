class GroupsController < ApplicationController
  def index
  	@groups = Group.where(:user => current_user)
  	return
  end
end
