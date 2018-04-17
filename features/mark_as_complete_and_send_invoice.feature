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
      | Måleri      | 1  |
      | Snickeri    | 2  |
      | Plåtslageri | 3  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
      | Stockholm | 2  |
      | Malmö     | 3  |
    Given the following companies exist
      | email           | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | greger@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following job ads exist
      | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | when_in_time | hour_day | active | company_username | company_city | company_id | id |
      | målare sökes | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | soon         | 8        | true   | Anders p         | Göteborg     | 1          | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id | first_name | last_name |
      | felix@mail.com | 12345678  | 12345678              | 1  | felix      | ottander  |
      | filip@mail.com | 12345678  | 12345678              | 2  | filip      | bergfelt  |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id |
      | Fisken   | 29 år målare | målare gbg  | 1            | 1        | 1       | 1  |
      | Filip    | 29 år målare | målare gbg  | 1            | 1        | 2       | 2  |
    Given the following applications exist
      | message    | job_id | profile_username | profile_id | job_title    | hired | complete | first_day  | last_day   |
      | I want job | 1      | Fisken           | 1          | målare sökes | true  | false    | 2018-01-01 | 2018-02-01 |

    Scenario: I create an invoice and see completed jobs change in index
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Visa ansökan/Skapa faktura"
      And I should see "Skapa faktura baserad på jobbet"
      And I fill in "quantity" with "100"
      And I fill in "amount" with "10000"
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
      And I click "LOGGA UT"
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      Then I should see "Admin redigerade en faktura"
      And I should not see "Visa ansökan/Skapa faktura"
      And I click "KONTROLLPANEL"
      And I should see "Redigera"
      And I should see "Radera"
      And the latest created invoice is being paid
      And I click "KONTROLLPANEL"
      And I click "Visa" in active invoices
      And I should see "Beskrivning: Måleri"
      And I should see "10000"
      And I should see "2018-01-01"
      And I should see "Fisken"
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
      Then I should see "Totalt fakturerat: 10000 kr"
      And I click "LOGGA UT"
      Given I am logged in as company "greger@mail.com"
      Given I am on control panel page
      Then I should see "Fisken skickade en ny faktura"
      And I click "Visa"
      Then I should not see "Klicka för att få fakturan på posten"
      Then I should not see "Klicka för 30 dagars fakturatid"
      And I fill in "feedback" with "Väldigt bra snubbe"
      And I click "Skicka feedback"
      And I should see "Sparat!"
      And I should see "Fakturaavgift ex moms: 0 SEK"
      Then I should not see "Rekommendera MyString till andra"
      And I select "4" from "rating"
      And I click "Skicka betyg"
      And I should see "Sparat!"
      And I should see "Fakturaavgift ex moms: 0 SEK"
      Then I should not see "Ge betyg till MyString"
