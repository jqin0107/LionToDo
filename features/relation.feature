Feature: join/leave an activity

  As an event participant
  I want to join or leave an activity

  Background: activites in database

    Given the following activites exist:
      | event_name      | creator_id        | location | current_size | max_size| date     |description          | category  | open_status |
      | Halloween Parade| 1                 | 6th ave  |   2          | 10      |2023-10-31|""                   | Others    |  Open |
      | Study Night     | 2                 | Butler   |   4          | 4       |2023-11-3 |"study night at lib" | Education | Open |
      | Skiing          |1                 | Bryant Park |  3           | 5       |2023-2-19|""                   |Entertainment|Open|
      | World Cup       |1                 | Mel's    |  3           | 5       |2022-12-4|""                   |Entertainment|Open|


    Given the following users exist:
      | user_name    | first_name | last_name | password |
      | tester1      | tfn1       | tln1      | abcdefgh |
      | tester2      | tfn2       | tln2      | 12345678 |

    Given the following relations exist:
      | user_id     | activity_id   |
      | 1           | 1             |
      | 2           | 2             |


    Then I go to the login page
    And  I fill in "Username" with "tester1"
    And  I fill in "Password" with "abcdefgh"
    And  I press "Login"

  Scenario: Join an activity
    When I go to the details page for "Skiing"
    And I follow "Participate!"
    Then the current_size of "Skiing" should be 4
    And I go to the user details page for "tester1"
    Then I should see "Skiing"
    Then I go to the details page for "Skiing"
    Then I should see "Leave!"


  Scenario: Join a full activity
    When I go to the details page for "Study Night"
    And I follow "Participate!"
    Then the current_size of "Study Night" should be 4
    Then I go to the details page for "Study Night"
    Then I should not see "Leave!"


  Scenario: Join a closed activity
    When I go to the details page for "World Cup"
    Then I should not see "Participate!"

  Scenario: Leave an activity
    When I go to the details page for "Halloween Parade"
    Then the current_size of "Halloween Parade" should be 2
    Then I follow "Leave!"
    Then the current_size of "Halloween Parade" should be 1
    Then I go to the details page for "Halloween Parade"
    Then I should see "Participate!"