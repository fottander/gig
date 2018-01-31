Feature: Apply to job
  As an user
  I order to show an employer that I´m interested in a job
  I would like to be able to send an application

  Background:
    Given the following categories exist
      | name   | id |
      | Målare | 1  |
    Given the following cities exist
      | name     | id |
      | Göteborg | 1  |
    Given the following companies exist
      | email           | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | anders@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following job ads exist
      | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | hour_week | active | company_username | company_city | company_id |
      | målare sökes | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     | 1          |
    Given the following users exist
      | email           | password  | password_confirmation | id |
      | felix@mail.com  | 12345678  | 12345678              | 1  |
      | greger@mail.com | 12345678  | 12345678              | 2  |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id |
      | Fisken   | målare 29 år | målare gbg  | 1            | 1        | 1       |

    Scenario: I apply to a job
      Given I am logged in as user "felix@mail.com"
      Given I am on the jobs page
      And I should see "målare"
      And I click "Ansök"
      And I should see "Jobbdetaljer"
      And I should see "målare sökes"
      And I should see "Anders p"
      And I should see "Göteborg"
      And I click "Ansök"
      And I should not see "Anställ"
      And I should not see "Jobbet har genomförts!"
      And I should not see "Diskutera & chatta"
      And I should not see "SKAPA FAKTURA"
      And I should see "Skapa ansökan"
      And I fill in "Skriv ansökan" with "I want job"
      And I click "Skapa"
      Then I should see "Ny ansökan skickad!"
      And I click "KONTROLLPANEL"
      Then I should see "målare sökes"
      And I click "Visa ansökan"
      Then I should see "I want job"
      And I should see "Diskutera & chatta"
      And I fill in "Svara på ansökan" with "Hallå svara"
      And I click "Skicka"
      Then I should see "Hallå svara"
      And I click "LOGGA UT"
      Given I am logged in as company "anders@mail.com"
      Given I am on control panel page
      And I should see "Fisken skapade en ansökan"
      Then I should see "Fisken skickade ett svar"
      And I click "målare sökes"
      And I click "Visa ansökan"
      And I click "Anställ"
      And I should see "Grattis! Du har anlitat personen."
      And I click "LOGGA UT"
      Given I am logged in as user "felix@mail.com"
      Given I am on the jobs page
      And I click "målare"
      Then I should see "Du har redan ansökt till detta jobbet!"
      And I click "KONTROLLPANEL"
      And I should see "målare sökes" in active applications
      And I click "Visa ansökan/Skapa faktura"
      And I should see "SKAPA FAKTURA"
      And I should not see "Diskutera & chatta"
      And I should not see "Anställ"
      And I should not see "Jobbet har genomförts!"
      And I fill in "description" with "Hej"
      And I fill in "quantity" with "100"
      And I fill in "amount" with "7000"
      And I fill in "first_day" with "2018-01-01"
      And I fill in "last_day" with "2018-12-12"
      And I fill in "user_reference" with "Felix"
      And I fill in "company_reference" with "Anders"
      And I click "Skapa faktura"
      And I should see "Jobbet har genomförts!"
      And I click "KONTROLLPANEL"
      And I click "Redigera"
      And I fill in "Enhet" with "100"
      And I click "Spara"
      Then I should see "Faktura ändrad"
      And I click "KONTROLLPANEL"
      And I should see "målare sökes" in done applications
      And I should not see "målare sökes" in active applications
      Then I should see "målare sökes" in active invoices
      And I click "LOGGA UT"
      Given I am logged in as company "anders@mail.com"
      Given I am on control panel page
      And I should see "Fisken redigerade en faktura"
      Then I should see "Fisken skickade en ny faktura"

    Scenario: I apply to a job without a profile
      Given I am on the jobs page
      And I should see "målare"
      And I click "Ansök"
      And I click "Ansök"
      Then I should see "Du måste logga in eller registrera dig innan du fortsätter."
      Given I am logged in as user "greger@mail.com"
      Given I am on the jobs page
      And I should see "målare"
      And I click "Ansök"
      And I click "Ansök"
      Then I should see "Var vänlig skapa en profil innan du ansöker till jobb"
