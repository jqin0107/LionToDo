Feature: Edit an existing activity

  As an event organizer
  So that I can start an event
  I want to include basic information about the activity I organize

  Background: activites in database

    Given the following activites exist:
      | event_name      | creator_id        | location | current_size | max_size| date     |description | category| open_status |
      | Halloween Parade| 1                 | 6th ave  |   2          | 10      |2022-10-31|""          |others  | Open |
      | Study Night     | 2                 | Butler   |   1          | 4       |2022-11-3 |"study night at lib"| education| Open |

    Given the following users exist:
      | user_name    | first_name | last_name | password |
      | tester1      | tfn1       | tln1      | abcdefgh |
      | tester2      | tfn2       | tln2      | 12345678 |

    Then I go to the login page
    And  I fill in "Username" with "tester2"
    And  I fill in "Password" with "12345678"
    And  I press "Login"

  Scenario: Edit current size to existing activity
    When I go to the activity edit page for "Study Night"
    And  I fill in "Current Size" with "3"
    And  I press "Update Activity Info"
    Then the current_size of "Study Night" should be 3

  Scenario: Edit and leave some empty fields
    When I go to the activity edit page for "Study Night"
    And  I fill in "Current Size" with ""
    And  I press "Update Activity Info"
    Then the current_size of "Study Night" should be 1


  Scenario: Edit without permission
    When I go to the activity edit page for "Halloween Parade"
    Then I should be on the details page for "Halloween Parade"

