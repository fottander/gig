Feature: Apply to job
  As an user
  I order to show an employer that I´m interested in a job
  I would like to be able to send an application

  Background:
    Given the following job ads exist
      | title        | description | requirement      | category | city | budget      | deadline   | duration | hour_week | active | company_username | company_city |
      | målare sökes | måla hus    | 2 års erfarenhet | målare   | gbg  | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
    Given the following profiles exist
      | username | description | category | city     | user_id |
      | Fisken   | målare gbg  | Målare   | Göteborg | 1       |

    Scenario: I apply to a job
      Given I am logged in as user "felix@mail.com"
      Given I am on the jobs page
      And I should see "målare"
      And I click "Apply"
      And I should see "Job details"
      And I should see "målare sökes"
      And I should see "Anders p"
      And I should see "Göteborg"
      And I click "Apply"
      And I should see "Create a job application"
      And I fill in "Message" with "I want job"
      And I click "Submit"
      Then I should see "New job application sent!"
      And I click "DASHBOARD"
      Then I should see "målare sökes"
