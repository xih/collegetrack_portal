require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^the following groups exist for user: "(.*)":$/ do |user, groups_table|
	user = User.where(:email => user).first
	groups_table.hashes.each do |group|
    	user.groups.create(group)
  	end
end

When /^I press the "(.*)" cell$/ do |text|
	page.find('.cell', :text => text).find(:xpath, "..").click
	
end

When /^I press the "(.*)" button$/ do |text|
  page.find('button', :text => "#{text}").click
end

Then /^I wait for a bit$/ do
	sleep 1
end

When /^I fill in "(.*)" with "(.*)"$/ do |title, value|
	page.find('a', :text => title).find(:xpath, "..").find('input').set value
end

And /^I press the "(.*)" category$/ do |category|
  page.find('#accordian ul li h3', :text => category).click
end

Then /^"(.*)" should be selected$/ do |item|
  page.find('a', :text => item)['class'] == '.selected'
end

When /^I select the filters: (.*)$/ do |filters|
  filters = filters.split(", ").reject { |f| f == "Student" }
  page.all('#accordian ul li h3').each do |category|
    category.click
    page.all('#accordian ul li ul li a').each do |link|
      if filters.include?(link.text)
        link.click
      end
  	end
  end
end

