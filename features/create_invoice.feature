Feature: Create invoice
  As an user
  In order to get my money for the work done
  I would like to be able to send an invoice to the company

  Background:
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following job ads exist
      | title        | description | requirement      | category | city | budget      | deadline   | duration | hour_week | active | company_username | company_city | company_id | id |
      | målare sökes | måla hus    | 2 års erfarenhet | målare   | gbg  | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     | 1          | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
    Given the following profiles exist
      | username | title        | description | category | city     | user_id | id |
      | Fisken   | 29 år målare | målare gbg  | Målare   | Göteborg | 1       | 1  |
    Given the following applications exist
      | message    | job_id | profile_username | profile_id | job_title    | hired | complete |
      | I want job | 1      | Fisken           | 1          | målare sökes | true  | true     |

    Scenario: I create an invoice
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Visa ansökan/Skapa faktura"
      And I should see "SKAPA FAKTURA"
      And I fill in "description" with "Hej"
      And I fill in "quantity" with "100"
      And I fill in "unit" with "234,5"
      And I fill in "amount" with "2345"
      And I fill in "first_day" with "2018-01-01"
      And I fill in "last_day" with "2018-12-12"
      And I fill in "user_reference" with "Felix"
      And I fill in "company_reference" with "Anders"
      And I click "Skapa faktura"
      Then I should see "Faktura skapad"
