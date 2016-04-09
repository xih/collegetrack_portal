Feature: Groups Tab
  As a College Track staff,
  I want to be able see the list of  groups that I have saved
  I also want to be able to add, update, and delete the groups

Background: Users have been added to the database  

  Given the following users exist:
  | email                   | password |
  | petrduong@gmail.com     | password |
  | jason.chern93@gmail.com | password |
  | shinyenhuang@gmail.com  | password |

  Given the following groups exist for user: "petrduong@gmail.com":
  | name          |   filters                                 |
  | Low GPA       |   2.5 - 3.0,2.0 - 2.5,0.0 - 2.0           |
  | Young         |   9th Grade,10th Grade                    |
  | Old           |   11th Grade,12th Grade                   |

  And I am on the login page
  And I login as "petrduong@gmail.com"


 Scenario: Add a Group
    Given I am on the groups tab
    And I go to the add button
    When I fill in "Group Name" with "High GPA"
    And I add the group filters: "4.0 +"
    And I press "Save"
    Then I wait a bit
    And I should be on the groups index page

  Scenario: Update a group to include race
    Given I am on the groups tab
    Then I should see "Low GPA"
    When I press the "Low GPA" cell
    Then I should be on the edit group page
    And I should see "Low GPA"
    And I press "Save"
    Then I should be on the groups index page
    And I should see "Low GPA"

    When I press the "Low GPA" cell
    Then I should see "Asian"
    Then I should see "Other"
    Then I should see "2.5 - 3.0"