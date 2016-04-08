class GroupsController < ApplicationController
  include SalesforceClient
  def index
  	@groups = Group.where(:user => current_user)
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

  def delete
  	name = params[:name]
  	if Group.exists?(:name => name)
  		group = Group.where(:name => name).first
  		group.destroy()
  	end
  	redirect_to groups_index_path
  	return
  end


  def create
  	name = params[:name]
  	filters = params[:filters]
  	if name and filters
  		if Group.exists?(:name => name)
  			group = Group.where(:name => name).first
  			group.filters = filters
  			group.save()
  		else
  			current_user.groups.create!(:name => name, :filters => filters)
  		end
  		return render nothing: true, status: 278
  	else
  		return render nothing: true, status: 500
  	end
  end
end
