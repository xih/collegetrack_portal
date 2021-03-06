module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the login page$/ then root_path
    when /^the email page$/ then new_email_path
    when /^the new email page$/ then new_email_path
    when /^the admin page$/ then admin_path
    when /^the groups tab$/ then groups_path
    when /^the groups index$/ then groups_index_path
    when /^the add button$/ then add_group_path
    when /^the edit group page$/ then edit_group_path
    when /^the Salesforce password reset page$/ then reset_salesforce_path

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)