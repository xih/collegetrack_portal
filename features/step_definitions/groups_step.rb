require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /the following groups exist for all users/  do |group_table|
    User.all.each do |user|
    	user.groups.create!(group_table.hashes)
  end
end

And /I click the Groups tab/ do
  click_link("Groups")
end
