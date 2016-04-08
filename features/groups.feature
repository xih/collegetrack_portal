  Feature: Viewing the groups
  As a College Track staff,
  In order to visualize the groups saved,
  I want to view the groups that are represented in the model as well as a button to add a new group.

Background:
  Given the following users exist:
  | email                | password |
  | afrankl@berkeley.edu | password |

  Given the following groups exist for all users:
  | name                     | filters                  |
  | African American Women   | African American, Female |

# Tests that clicking Group Tab goes to Groups Page
Scenario: Go to Groups page
  Given I am on the login page
  And I login as "afrankl@berkeley.edu"
  And I click the Groups tab
  Then I should see "African American Women"
  And I should not see "BCC:"
  
# @AVI and Team: Tests if "+" button links to Create a New Group page
Scenario: Create a new group
  When I press "+"
  Then I am on the new group page # make sure the "new group" page is called "new group", or change this line
  And I see "Group Name" # make sure there is a text field named "Group Name"
  And I should not see "African American Women"

# Sad Path: Creating a New Group with the Same Name as pre-existing group should NOT work (get flash notice)
Scenario: Naming a new group the same name as an existing group
  Given I fill in 'Group Name' with "African American Women"
  And I press "Save Group" # NAME THE BUTTON "SAVE GROUP"
  # If link and not button replace with: And I follow "Save Group"
  Then I should see "This group name already exists." #use a flash or something to just show this on the page so they can fix the name

# This tests if the user can select FILTERS to add to group on the second group view (implement Accordion of Filters)
# Also need to implement: List of Current Filters
Scenario: Naming a new group and selecting filters for it
  Given I fill in 'Group Name' with "Spanish Speaking 11th Graders"
  And I add the filters: Spanish,11th Grade
  And I press "Save Group"
  # If link and not button replace with: And I follow "Save Group"
  Then I am on the new group page
  And I should see "Spanish Speaking 11th Graders"
  And I should see "African American Women"
  
# Checks that we can REACH the Editing Page for the Particular Group
Scenario: Editing an existing group
  Given I press "Spanish Speaking 11th Graders" # Step for this may not work
  # If link and not button replace with : And I follow "Spanish Speaking 11th Graders"
  Then I should see "Spanish Speaking 11th Graders"
  And I should not see "African Amerian Women" #checks that we went to Spanish Speaking 11th Graders Group

# Checks that we can successfully edit and save our changes for a particular group
Scenario: Renaming the group and changing filters
  Given I fill in 'Group Name' with "Spanish Speaking 12th Graders"
  And I click the x button on "11th Grade"
  And I add the filters: 12th Grade
  And I press "Save Group" 
  # If link and not button replace with: And I follow "Save Group"
  Then I should see "Spanish Speaking 12th Graders"
  And I should see "African American Women"
  And I should not see "Spanish Speaking 11th Graders"

Scenario: Canceling edits to group in the edit page
  Given I press "Spanish Speaking 11th Graders"
  # If link and not button replace with : And I follow "Spanish Speaking 11th Graders"
  I fill in 'Group Name' with "Preschool Kids"
  And I press "Cancel"
  # If link and not button replace with: And I follow "Cancel"
  Then I should see "Spanish Speaking 12th Graders"
  And I should not see "Preschool kids"
  
Scenario: Deleting a group
  Given I press "African American Women"
  # If link and not button replace with : And I follow "African American Women"
  And I press "Delete"
  # If link and not button replace with: And I follow "Delete"
  And I should see "Spanish Speaking 12th Graders"
  And I should not see "African American Women"
