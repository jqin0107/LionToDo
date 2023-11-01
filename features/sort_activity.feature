Feature: sort activities

  As a person who wants to join activities
  So that I can find the most recent events or activities in the right category
  I want to sort the activities

  Background: activites in database

    Given the following activites exist:
      | event_name      | creator_id        | location | current_size | max_size| date     |description | category| open_status |
      | Study Night     | 1                 | Butler   |   1          | 4       |2022-11-3 |"study night at lib"| Education| Open |
      | Halloween Parade| 1                 | 6th ave  |   2          | 10      |2022-10-31|""          |Others  | Open|
      | World Cup       |1                 | Mel's    |  3           | 5       |2022-12-19|""                   |Entertainment|Close|


    Given the following users exist:
      | user_name    | first_name | last_name | password |
      | tester1      | tfn1       | tln1      | abcdefgh |
      | tester2      | tfn2       | tln2      | 12345678 |

    Then I go to the login page
    And  I fill in "Username" with "tester1"
    And  I fill in "Password" with "abcdefgh"
    And  I press "Login"



  Scenario: sort movies alphabetically
    And  I follow "Event Name"
    Then I should see "Halloween Parade" before "Study Night"

  Scenario: sort movies in increasing order of release date
    When I follow "Date"
    Then I should see "Halloween Parade" before "Study Night"

  Scenario: all categories unchecked
    Then I uncheck the following categories: Arts, Entertainment, Education, Sports, Outdoor, Others
    And I press "Refresh"
    Then I should see all the activities

  Scenario: to see only open events
    Then I check "event_status"
    And I press "Refresh"
    Then I should not see "World Cup"