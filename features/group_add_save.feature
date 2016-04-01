Feature: As a College Track staff,
    So that when I send in emails to multiple students multiple times
    I want it to be able to group them as my faves group.
    
Background: Users have been added to the database  

  Given the following users exist:
  | email                   | password |
  | petrduong@gmail.com     | password |
  | jason.chern93@gmail.com | password |
  | shinyenhuang@gmail.com  | password |
  
  And I am on the groups page
  Then I should see "groups"

Scenario: Adding a grouop
    
    Given I see the add group button
    And I click the plus button
    Then I should see a new page where I can input a new group
    
Scenario: Saving a group
    Given that I am on the new group page
    When I fill in "new group" with "my faves"
    And I add the filters female and african american
    And I press "Save"
    Then I should be on the group home page
    And I should "my faves"