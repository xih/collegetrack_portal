When /^I select the filters: (.*)$/ do |filters|
  filters = filters.split(", ").reject { |f| f == "Student" }
  # page.all('#accordian ul li h3').each do |category|
  #   category.click
    page.all('#accordian ul li ul li a').each do |link|
      if filters.include?(link.text)
        link.click
      end
  	# end
  end
end

When /^I save the filters$/ do
	page.find('#save_filter').click
end

And /^I see the filters: (.*)$/ do |filters|
	filters = filters.split(", ")
	page.all('#accordian ul li ul li a').each do |element|
		element.should be_visible
	end
end

Then /^the following filters should be selected: (.*)$/ do |filters|
	page.all('#accordian ul li ul li a').each do |element|
		if filters.include?(element.text)
			element['class'].should == 'selected'
		end
	end
end

And /^I press the "(.*)" category$/ do |category|
  page.find('#accordian ul li h3', :text => category).click
end

Then /^(?:|I )click the x button on "(.*)"$/ do |filters|
  filters = filters.split(",")
  page.all('#filters .ui_fil').each do |filter|
    if filters.include?(filter.find('.left_fil').text)
      filter.find('.x').click
    end
  end
  sleep 3
end