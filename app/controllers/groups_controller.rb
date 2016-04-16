class GroupsController < ApplicationController
  include SalesforceClient
  def index
  	@groups = current_user.groups
  	return
  end

  def edit
  	@filters = params[:filters]
  	@name = params[:name]
  	@group = Group.where(:name => params[:name], :filters => params[:filters])
  	return
  end

  def add
    return
  end

  # def add_emails
  #   emails = params[:emails]
  #   @group = Group.where(:name => params[:name], :filters => params[:filters])
  #   @list = @group.list_of_additional_emails
  #   return
  # end

  def delete
  	name = params[:name]
  	if Group.exists?(:name => name)
  		group = current_user.groups.where(:name => name).first
  		group.destroy()
  	end
  	redirect_to groups_index_path
  	return
  end


  def create
  	name = params[:name]
  	filters = params[:filters]
  	if name and filters
  		if current_user.groups.exists?(:name => name)
  			group = current_user.groups.where(:name => name).first
  			group.filters = filters
  			group.save()
  		else
  			current_user.groups.create!(:name => name, :filters => filters)
  		end
  		render nothing: true, status: 278
  	else
  		render nothing: true, status: 278
  	end
  end
end
