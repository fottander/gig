Feature: Mark As complete and send invoice
  As an user
  In order to get my money for the work done
  I would like to be able to send an invoice to the company

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
      | Snickare    | 2  |
      | Plåtslagare | 3  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
      | Stockholm | 2  |
      | Malmö     | 3  |
    Given the following companies exist
      | email           | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | greger@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following job ads exist
      | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | hour_week | active | company_username | company_city | company_id | id |
      | målare sökes | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     | 1          | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
      | filip@mail.com | 12345678  | 12345678              | 2  |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id |
      | Fisken   | 29 år målare | målare gbg  | 1            | 1        | 1       | 1  |
      | Filip    | 29 år målare | målare gbg  | 1            | 1        | 2       | 2  |
    Given the following applications exist
      | message    | job_id | profile_username | profile_id | job_title    | hired | complete |
      | I want job | 1      | Fisken           | 1          | målare sökes | true  | false    |

    Scenario: I create an invoice and see completed jobs change in index
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Visa ansökan/Skapa faktura"
      And I should see "SKAPA FAKTURA"
      And I fill in "description" with "Hej"
      And I fill in "quantity" with "100"
      And I fill in "amount" with "10000"
      And I fill in "first_day" with "2018-01-01"
      And I fill in "last_day" with "2018-12-12"
      And I fill in "user_reference" with "Felix"
      And I fill in "company_reference" with "Anders"
      And I click "Skapa faktura"
      Then I should see "Faktura skapad"
      And I click "LOGGA UT"
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Fakturor"
      And I click "Visa/godkänn faktura"
      And I click "Redigera"
      And I fill in "Enhet" with "100"
      And I click "Spara"
      And I click "Fakturor"
      And I click "Visa/godkänn faktura"
      And I click "Godkänn & aktivera"
      Then I should see "Faktura godkänd och aktiverad"
      And I click "LOGGA UT"
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      Then I should see "Admin redigerade en faktura"
      And I should not see "Visa ansökan/Skapa faktura"
      And the latest created invoice is beeing activated
      And I click "KONTROLLPANEL"
      And I click "Visa" in active invoices
      Then I should see "Hej"
      And I should see "10000"
      And I should see "2018-01-01"
      And I should see "Felix"
      And I should see "Anders"
      And I click "ALLA FRILANSARE"
      And I should see "Genomförda jobb: 1" at "Fisken"
      And I should see "Totalt fakturerat: 10 000 - 20 000 kr" at "Fisken"
      Then I should see "Genomförda jobb: 0" at "Filip"
      And I should see "Totalt fakturerat: 0 - 10 000 kr" at "Filip"
      And I click "Fisken"
      Then I should see "Antal genomförda jobb: 1"
      And I should see "Totalt fakturerat: 10 000 - 20 000 kr"
      And I click "HITTA JOBB"
      And I click "målare sökes"
      Then I should see "Antal genomförda jobb: 1"
      And I click "KONTROLLPANEL"
      Then I should see "Totalt fakturerat: 12500 kr"
      And I click "LOGGA UT"
      Given I am logged in as company "greger@mail.com"
      Given I am on control panel page
      Then I should see "Fisken skickade en ny faktura"
