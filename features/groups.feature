@javascript

Feature: Viewing the groups
  As a College Track staff,
  I want to be able see the list of filter groups that I have saved
  I also want to be able to add, update, and delete the list of filter groups

Background: Users have been added to the database  

  Given the following users exist:
  | email                   | password |
  | petrduong@gmail.com     | password |
  | jason.chern93@gmail.com | password |
  | shinyenhuang@gmail.com  | password |

  And I am on the login page
  And I login as "petrduong@gmail.com"
  And I go to the groups tab
  Given the following groups exist for user: "petrduong@gmail.com":
  | name          |   filters                                 |
  | Low GPA       |   2.5 - 3.0,2.0 - 2.5,0.0 - 2.0           |
  | Young         |   9th Grade,10th Grade                    |
  | Old           |   11th Grade,12th Grade                   |


 Scenario: Add a Group
    Given I go to the add button
    When I fill in "Group Name" with "High GPA"
    And I add the filters: "4.0 +"
    And I press "Save"
    Then I should see "High GPA"

  Scenario: Update a group to include race
    Given I should see "Low GPA"
    When I click on "Low GPA"
    And I add the filters: "Asian,Other"
    And I press "Save"
    Then I should see "Low GPA"

    When I click on "Low GPA"
    Then I should see "Asian"
    Then I should see "Other"
    Then I should see "2.5 - 3.0"