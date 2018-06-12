Feature: Admin edit and delete invoices
  As a system owner
  In order to manage the system
  I would like to be able to edit and delete invoices

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following users exist
      | email           | first_name | last_name | password  | password_confirmation | id   |
      | felix@yahoo.com | felix      | ottander  | 12345678  | 12345678              | 9999 |
      | johan@yahoo.com | johan      | stjärtis  | 12345678  | 12345678              | 9998 |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id   | age        |
      | Fisken   | målare 29 år | målare gbg  | 1            | 1        | 9999    | 9999 | 1988-09-14 |
      | Greger   | målare 29 år | målare gbg  | 1            | 1        | 9998    | 9998 | 1988-09-14 |
    Given the following companies exist
      | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
      | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
      | johan@mail.com | brag | johans p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9998 |
    Given the following ezinvoices exist
      | org_number | company_name | company_address | company_zip | company_city | company_email | description | amount | user_reference | terms | updated_at | paid  | user_id    |
      | 1234       | greger ab    | södra 1         | 412         | gbg          | a@mail.com    | abc fakt    | 120    | felix          | 15    | 2017-11-01 | false | 9999       |
    Given the following invoices exist
      | description | amount | user_reference | terms | id    | company_id | updated_at | paid  | user_id    |
      | abc         | 120    | felix          | 15    | 9999  | 9999       | 2017-11-01 | false | 9999       |

    Scenario: I see ezinvoices and search by id
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Fakturor"
      And I click "Visa/godkänn faktura"
      And I should see "abc"
      And I click "Redigera"
      And I fill in "Beskrivning" with "Målarjobb hos greger"
      And I fill in "Antal timmar" with "100"
      And I fill in "Timlön" with "100"
      And I edit hidden field amount and fill "1000"
      And I fill in "Fakturaavgifter exkl moms" with "100"
      And I fill in "Första dag(ex. 2018-xx-xx)" with "2018-01-01"
      And I fill in "Sista dag(ex. 2018-xx-xx)" with "2018-10-01"
      And I fill in "Referens(förnamn & efternamn)" with "Fisken"
      And I fill in "Företagsreferens" with "Tjoho"
      And I click "Spara"
      And I should see "Faktura ändrad"
      And I click "Fakturor"
      Then I should see "User ID: 9999"
      And I should see "Företags ID: 9999"
      And I click "Visa/godkänn faktura"
      And I should see "Beskrivning: Målarjobb hos greger"
      And I should see "Antal timmar: 100st"
      And I should see "Timlön: 100kr/timma"
      And I should see "Summa: 1000 SEK"
      And I should see "Bruttolön inkl semesterersättning: 1120 SEK"
      And I should see "Summa inkl. moms: 1844"
      And I should see "Totalsumma inkl. moms: 1969"
      Then I should see "Startdag: 2018-01-01"
      And I should see "Sista dag: 2018-10-01"
      And I should see "Referens: Fisken"
      And I should see "Företagsreferens: Tjoho"
      And I click "Radera"
      Then I should see "Faktura raderad"
      And I click "Snabbfakturor"
      And I click "Visa/godkänn faktura"
      And I should see "abc fakt"
      And I click "Redigera"
      And I fill in "Beskrivning" with "Målarjobb hos filip"
      And I click "Spara"
      And I should see "Faktura ändrad"
      And I click "Snabbfakturor"
      And I click "Visa/godkänn faktura"
      Then I should see "Målarjobb hos filip"
      And I click "Radera"
      Then I should see "Faktura raderad"
