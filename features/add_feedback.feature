Feature: Extend invoice and add feedback
  As a company user
  In order to help a freelancer get more jobs
  I would like to be able to give feedback

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id   |
      | felix@mail.com | 12345678  | 12345678              | 9999 |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id   |
      | Fisken   | målare 29 år | målare gbg  | 1            | 1        | 9999    | 9999 |
    Given the following invoices exist
      | description | amount | user_reference | terms |id | company_id | user_id | profile_id | job_id | job_title    | paid  | rating |
      | ref         | 1200   | felix          | 15    | 1 | 1          | 9999    | 9999       | 1      | Målare sökes | true  |        |
      | fer         | 1200   | felix          | 15    | 2 | 1          | 9999    | 9999       | 1      | Målare sökes | true  | 5      |
      | tyr         | 1200   | felix          | 15    | 3 | 1          | 9999    | 9999       | 1      | Målare sökes | true  | 3      |
      | abc         | 1200   | felix          | 15    | 4 | 1          | 9999    | 9999       | 1      | Målare sökes | false |        |

    Scenario: I give feedback with extended post, terms and rating
      Given I am logged in as company "felix@mail.com"
      Given I am on the home page
      And I click "ALLA FRILANSARE"
      And I click "Fisken"
      And I should not see "Betyg"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Summa ex moms: 1200 SEK"
      And I should see "Fakturaavgift ex moms: 0 SEK"
      And I should see "Totalsumma inkl moms: 1500 SEK"
      And I should see "Rekommendera MyString till andra"
      And I should see "Ge betyg till MyString"
      And I fill in "feedback" with "Väldigt bra snubbe"
      And I click "Skicka feedback"
      And I should see "Sparat!"
      And I select "5" from "rating"
      And I click "Skicka betyg"
      And I should see "Sparat!"
      And I click "ALLA FRILANSARE"
      And I click "Fisken"
      And I should see "Betyg 5/5"
      And I should see "Betyg 4.3/5"
      Then I should see "Väldigt bra snubbe"
      And I click "KONTROLLPANEL"
      And I click "Visa/Kontrollera"
      And I should see "Summa ex moms: 1200 SEK"
      And I should see "Fakturaavgift ex moms: -100 SEK"
      And I should see "Totalsumma inkl moms: 1375 SEK"
      And I should not see "Rekommendera MyString till andra"
      And I should not see "Ge betyg till MyString"
      And I click "Lägg till" terms button
      And I should not see "Klicka för 30 dagars fakturatid(+500kr)"
      And I should see "Summa ex moms: 1200 SEK"
      And I should see "Fakturaavgift ex moms: 400 SEK"
      And I should see "Totalsumma inkl moms: 2000 SEK"
      And I click "Lägg till" post button
      And I should not see "Klicka för att få fakturan på posten(+40kr)"
      And I should see "Summa ex moms: 1200 SEK"
      And I should see "Fakturaavgift ex moms: 440 SEK"
      And I should see "Totalsumma inkl moms: 2050 SEK"

    Scenario: I give feedback with extended post, terms and rating in a different order
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Summa ex moms: 1200 SEK"
      And I should see "Fakturaavgift ex moms: 0 SEK"
      And I should see "Totalsumma inkl moms: 1500 SEK"
      And I should see "Rekommendera MyString till andra"
      And I should see "Ge betyg till MyString"
      And I click "Lägg till" terms button
      And I should not see "Klicka för 30 dagars fakturatid(+500kr)"
      And I should see "Summa ex moms: 1200 SEK"
      And I should see "Fakturaavgift ex moms: 500 SEK"
      And I should see "Totalsumma inkl moms: 2125 SEK"
      And I click "Lägg till" post button
      And I should not see "Klicka för att få fakturan på posten(+40kr)"
      And I should see "Summa ex moms: 1200 SEK"
      And I should see "Fakturaavgift ex moms: 540 SEK"
      And I should see "Totalsumma inkl moms: 2175 SEK"
      And I select "5" from "rating"
      And I click "Skicka betyg"
      And I should see "Sparat!"
      And I fill in "feedback" with "Väldigt bra snubbe"
      And I click "Skicka feedback"
      And I should see "Sparat!"
      And I click "ALLA FRILANSARE"
      And I click "Fisken"
      And I should see "5/5"
      Then I should see "Väldigt bra snubbe"
      And I click "KONTROLLPANEL"
      And I click "Visa/Kontrollera"
      And I should see "Summa ex moms: 1200 SEK"
      And I should see "Fakturaavgift ex moms: 440 SEK"
      And I should see "Totalsumma inkl moms: 2050 SEK"
      And I should not see "Rekommendera MyString till andra"
      And I should not see "Ge betyg till MyString"
