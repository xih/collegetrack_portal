@javascript
Feature: Filter students to email by categories

  As a College Track staff,
  So I can send emails to specific groups
  I want to be able to filter through groups of students

Background: Users have been added to the database  

  Given the following users exist:
  | email                   | password |
  | petrduong@gmail.com     | password |
  | jason.chern93@gmail.com | password |
  | shinyenhuang@gmail.com  | password |

  And I am on the login page
  And I login as "petrduong@gmail.com"

Scenario: Add a single filter with default filter selected

  Given I see the filters: Student
  And I add the filters: Oakland Technical High School
  Then the recipient fields should contain: aaronbrowne29@gmail.com, angelah.asiimwe@yahoo.com, williamshuang2147@gmail.com

Scenario: Adding multiple filters with existing filters

  Given I see the filters: Student,Oakland Technical High School
  And the recipient fields should contain: aaronbrowne29@gmail.com, angelah.asiimwe@yahoo.com, williamshuang2147@gmail.com
  And I add the filters: Asian
  Then the recipient fields should contain: amy.huynh123@yahoo.com

Scenario: Removing a single filter through the x button

  Given I see the filters: Student,Oakland Technical High School,Asian
  And the recipient fields should contain: amy.huynh123@yahoo.com
  And I click the x button on "Oakland Technical High School"
  Then the recipient fields should contain: alexfeng420@gmail.com, amyhaunter@gmail.com, huangg.crystal@gmail.com

Scenario: Deselecting filters by changing filters

  Given I see the filters: Student,Oakland Technical High School,Asian
  And the recipient fields should contain: amy.huynh123@yahoo.com
  And I remove the filters: Oakland Technical High School
  Then the recipient fields should contain: alexfeng420@gmail.com, amyhaunter@gmail.com, huangg.crystal@gmail.com

# Scenario: Filter by university as staff
#   As a College Track staff
#   Given I see the filters: University of Southern California
#   And I add the filters: Stanford
#   Then the recipient fields should contain: darwin.braun@mante.name, marcia@boylezboncak.io

Scenario: Filter by gender as staff
  Given I see the filters: Student 
  And I add the filters: Female
  Then the recipient fields should contain: abigail.l.2018@lighthousecharter.org, adawkins715@gmail.com

# Scenario: Filter by year as staff
#   As a College Track staff
#   Given I see the filters: sophomore
#   And I add the filters: freshmen
#   Then the recipient fields should contain: darwin.braun@mante.name, mikel.mitchell@oconnell.org

Scenario: Filter by gender and race
  Given I see the filters: Student,Female
  And I add the filters: African American
  Then the recipient fields should contain: adawkins715@gmail.com, ciaras62@gmail.com
 


Scenario: Filter by language as staff
  Given I see the filters: Student
  And I add the filters: Spanish
  Then the recipient fields should contain: yasmineflores2013@gmail.com, sand.3401@mail.com

# Scenario: Filter by non-citizens as staff
#   As a College Track staff
#   When I select no citizenship access filter
#   Then I should see student’s emails who aren’t US citizens (illegally documented)

# Scenario: Filter by thresholds as staff
#   As a College Track staff
#   When I select 33 ACT and 3.8 GPA
#   Then I should see only students with these thresholds

# Scenario: Filter by specific groups as staff
#   As a College Track staff
#   When I select Oakland filter
#   Then I should see see student emails that correspond to these centers
