Feature: custmize your schedule

  As an officer at Columbia University
  So that I can post new events
  I want to add details about the event I post

Background: events in database

  Given the following events exist:
  | title     | location | tags             |  event_date  |
  | Event1    | Mudd     | Computer Science |   2023-11-25 |
  | Event2    | NWC      | Speech           |   2023-11-26 |
  | Event3    | Uris     | Business         |   2023-11-25 |
  | Event4    | Lerner   | Career Fair      |   2023-11-11 |

Given my account is:
  | email                  | password      | 
  | saas@columbia.edu      | group25       | 

Scenario: Log in to my user page
  When I go to the login page
  And  I fill in "Email" with "saas@columbia.edu"
  And  I fill in "Password" with "group25"
  And  I press "Login"
  Then I should see "My To-do List"

Scenario: create new events with tags
  When I go to the new page
  And  I fill in "Title" with "New events"
  And  I fill in "Tags" with "Computer Science"
  And  I press "Save events"
  Then the tags of "New events" should be "Computer Science"

Scenario: update existing events 
  When I go to the edit page for "New events"
  And  I fill in "Location" with "Lerner"
  And  I press "Update Event Info"
  Then the location of "New events" should be "Lerner"

Scenario: delete event
  Given I am on the details page for "Alien"
  And   I follow "Delete"
  Then  I should be on the home page