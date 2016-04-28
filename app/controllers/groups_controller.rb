class GroupsController < ApplicationController
  include SalesforceClient
  def index
  	@groups = current_user.groups
  	return
  end

  def edit
  	@group = current_user.groups.where(:id => params[:id].to_i).first
    @name = @group.name
    @id = @group.id
    @filters = @group.filters
    @extra_emails = @group.extra_emails
  	return
  end

  def add
    return
  end

  def delete
    id = params[:id].to_i
  	if current_user.groups.exists?(:id => id)
  		group = current_user.groups.where(:id => id).first
  		group.destroy()
  	end
  	redirect_to groups_index_path
  	return
  end


  def create
    extra_emails = params[:extra_emails]
  	name = params[:name]
  	filters = params[:filters]
    id = params[:id].to_i
  	if name and filters
  		if current_user.groups.exists?(:id => id)
  			group = current_user.groups.where(:id => id).first
  			group.filters = filters
        group.extra_emails = extra_emails
  			group.save()
  		else
  			current_user.groups.create!(:name => name, :filters => filters, :extra_emails => extra_emails)
  		end
  		render nothing: true, status: 278
  	else
  		render nothing: true, status: 278
  	end
  end
end
