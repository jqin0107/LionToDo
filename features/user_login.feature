Feature: User login

  As a user, I should be able to login to my account

Background: users in database

  Given the following users exist:
  | user_name    | first_name | last_name | password |
  | tester1      | tfn1       | tln1      | abcdefgh |
  | tester2      | tfn2       | tln2      | 12345678 |

Scenario: don't login to user
  When I go to the welcome page
  Then I should be on the login page

Scenario: try to edit without login
  When I go to the edit page for "tester1"
  Then I should be on the login page

Scenario: try to see activities without login
  When I go to the home page
  Then I should be on the login page

Scenario: login to user
  When I go to the login page
  And  I fill in "Username" with "tester1"
  And  I fill in "Password" with "abcdefgh"
  And  I press "Login"
  Then I should be on the home page

Scenario: wrong password
  When I go to the login page
  And  I fill in "Username" with "tester2"
  And  I fill in "Password" with "randompassword"
  And  I press "Login"
  Then I should be on the login page