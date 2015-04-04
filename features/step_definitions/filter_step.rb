Given /^I see the filters: (.*)$/ do |filters|
  step %{I add the filters: #{filters}}
end

Given /^I (?:|add|remove) the filters: (.*)$/ do |filters|
  options = { :Location => ["Oakland"], :Race => ["Asian", "Black", "White"], :Gender => ["Male", "Female"], :Year => ["2010", "2011", "2012"]}
  filters = filters.split(",")
  filters.each do |filter|
    if filter === "Oakland"
      next
    end
    options.each do |category, values|
      if values.include?(filter)
        click_link('change filters')
        find('h3', text: category).click
        click_link(filter)
        click_button("save_filter")
      end
    end
  end
end

Then /^(?:|I )click the x button on "(.*)"$/ do |filters|
  filters = filters.split(",")
  filters.each do |filter|
    page.all('.ui_fil').each do |elem|
      within(elem) do |el|
        if find('.left_fil').text == filter
          find('.x').click
        end
      end
    end
  end
end

Then /^the recipient fields should contain: (.*)$/ do |emails|
  emails = emails.split(" ")
  expect(page).to have_field('email_bcc', :with => emails.join(", "))
end