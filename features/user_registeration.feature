Feature: User registeration

  As a new user, I should be able to register a new account

Background: users in database

  Given the following users exist:
  | user_name    | first_name | last_name | password |
  | tester1      | tfn1       | tln1      | abcdefgh |
  | tester2      | tfn2       | tln2      | 12345678 |

Scenario: register new user
  When I go to the register page
  And  I fill in "Username" with "tester3"
  And  I fill in "First Name" with "tfn3"
  And  I fill in "Last Name" with "tln3"
  And  I fill in "Password" with "tstpwd3"
  And  I press "Register"
  Then I should be on the home page

Scenario: register new user with duplicated user name
  When I go to the register page
  And  I fill in "Username" with "tester1"
  And  I fill in "First Name" with "tfn1"
  And  I fill in "Last Name" with "tln1"
  And  I fill in "Password" with "tstpwd1"
  And  I press "Register"
  Then I should be on the register page