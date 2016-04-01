require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /the following groups exist for all users/  do |group_table|
    User.all.each do |user|
    	user.groups.create(group_table.hashes)
  end
end

When /^I click Groups to change tabs$/ do
  click_button groups_path
end

And /^I sign into college track$/ do
	set_omniauth(user_email)
    @current_user = User.find_by_email(user_email)
    click_link("Sign in with Google")
end

