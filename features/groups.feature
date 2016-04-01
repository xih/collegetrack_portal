  Feature: Viewing the groups
  As a College Track staff,
  In order to visualize the groups saved,
  I want to view the groups that are represented in the model as well as a button to add a new group.

Background:
  Given the following users exist:
  | name                   | email                | role | password |
  | Avi Frankl             | afrankl@berkeley.edu | Admin| password |

  Given the following groups exist for all users:
  | name       | filters              |
  | High GPA   | GPA > 3.0            |
  | Low GPA    | GPA < 2.5            |  
  | Medium GPA | GPA > 2.5, GPA < 3.5 |  

Scenario: Log in and see the groups
  
  Given I am an authorized user
  And I login as "afrankl@berkeley.edu"
  Then I should be on the new email page
  Then I should see "Groups"

  When I click Groups to change tabs
  Then I should see "High GPA"
  Then I should see "Low GPA"
  Then I should see "Medium GPA"
  Then I should see "+"