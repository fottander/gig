Feature: Post job ad
  As a company
  In order to find workers
  I would like to be able to post a job ad

  Background:
    Given the following companies exist
      | email          | name | address | zip_code | city | org_number | phone | password  | password_confirmation |
      | felix@mail.com | bill | gatan 3 | 536      | gbgb | 3453324533 | 98789 | 12345678  | 12345678              |

    Scenario: Company tries to post without being logged in
      Given I am on the home page
      And I click "POST JOB"
      Then I should see "You need to sign in or sign up before continuing."

    Scenario: Company posts an ad
      Given I am on the home page
      Given I am logged in as company "felix@mail.com"
      And I click "POST JOB"
      And I should see "Post a job ad"
      And I fill in "Title" with "målare"
      And I fill in "Description" with "måla hus"
      And I fill in "Requirement" with "inga"
      And I fill in "Category" with "målare"
      And I fill in "City" with "göteborg"
      And I fill in "Budget" with "130kr/timma"
      And I fill in "Deadline" with "2017-10-10"
      And I fill in "Duration" with "5 dagar"
      And I fill in "Hours/week" with "30 timmar i veckan"
      And I click "Post job"
      Then I should see "New job created!"