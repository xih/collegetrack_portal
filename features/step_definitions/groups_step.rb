require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^the following groups exist for user: "(.*)":$/ do |user, groups_table|
	user = User.where(:email => user).first
	groups_table.hashes.each do |group|
    	user.groups.create!(group)
  end
end

