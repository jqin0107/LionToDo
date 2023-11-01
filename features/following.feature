Feature: follow/unfollow a user

  As a user
  I want to follow & unfollow other users

  Background: activites in database

    Given the following activites exist:
      | event_name      | creator_id        | location | current_size | max_size| date     |description          | category  | open_status |
      | Halloween Parade| 1                 | 6th ave  |   2          | 10      |2022-10-31|""                   | Others    |  Open |
      | Study Night     | 2                 | Butler   |   4          | 4       |2022-11-3 |"study night at lib" | Education | Open |
      | World Cup       |1                 | Mel's    |  3           | 5       |2022-12-19|""                   |Entertainment|Open|

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

  Scenario: Follow a user
    When I follow "tfn2 tln2"
    And I follow "Follow"
    Then I go to the home page
    Then I follow "My Followings"
    Then I should see "Study Night"
    And I should not see "World Cup"


  Scenario: Unfollow a user
    When I follow "tfn2 tln2"
    And I follow "Follow"
    Then I go to the home page
    Then I follow "My Followings"
    Then I should see "Study Night"
    Then I go to the home page
    Then I follow "tfn2 tln2"
    Then I follow "Unfollow"
    Then I go to the home page
    Then I follow "My Followings"
    Then I should not see "Study Night"