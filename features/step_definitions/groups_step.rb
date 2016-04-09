require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^the following groups exist for user: "(.*)":$/ do |user, groups_table|
	user = User.where(:email => user).first
	groups_table.hashes.each do |group|
    	user.groups.create(group)
  	end
end

And /^I check the page$/ do
	puts page.body
end

When /^I press the "(.*)" cell$/ do |text|
	page.find('.cell', :text => text).find(:xpath, "..").click
	
end

When /^I press the "(.*)" button$/ do |text|
	page.find('button', :text => "#{text}").click
end

Then /^I wait a bit$/ do
	sleep 5
end

When /^I fill in "(.*)" with "(.*)"$/ do |title, value|
	page.find('a', :text => title).find(:xpath, "..").find('input').set value
end

Given /^I (?:|add|remove) the group filters: (.*)$/ do |filters|
  filters = filters.split("\s*,\s*").reject { |f| f == "Student" }
  page.all('#accordian ul li h3').each do |category|
    category.click
    page.all('#accordian ul li ul li a').each do |link|
      if filters.include?(link.text)
        link.click
      end
  	end
  end
end

