Feature: A company hires a person
  As a company
  In order to employ good people
  I would like to be able to hire a profile through an application

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
      | Snickare    | 2  |
      | Plåtslagare | 3  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
      | Stockholm | 2  |
    Given the following companies exist
      | email           | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | greger@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following job ads exist
      | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | when_in_time | hour_day | active | company_username | company_city | company_id | id |
      | målare sökes | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | soon         | 8        | true   | Anders p         | Göteborg     | 1          | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id | first_name | last_name |
      | felix@mail.com | 12345678  | 12345678              | 1  | felix      | ottander  |
    Given the following profiles exist
      | username | description | category_ids | city_ids | user_id | id | age        |
      | Fisken   | målare gbg  | 1            | 1        | 1       | 1  | 1988-09-14 |
    Given the following applications exist
      | message    | job_id | profile_username | profile_id | job_title    |
      | I want job | 1      | Fisken           | 1          | målare sökes |

    Scenario: I hire a profile
      Given I am logged in as company "greger@mail.com"
      Given I am on control panel page
      And I click "Visa annons"
      And I should see "Fisken"
      And I click "Visa"
      And I should see "I want job"
      And I fill in "Skriv till Fisken" with "Bra då kör vi"
      And I click "Skicka"
      Then I should see "Bra då kör vi"
      And I fill in "Startdag(t.ex. 2018-11-01)" with "2018-01-01"
      And I fill in "Sista dag(t.ex. 2018-12-30)" with "2018-02-20"
      And I fill in "Bruttolön(t.ex. 150)kr/timma" with "100"
      And I click "Anställ"
      Then I should see "Något gick fel. Försök igen eller kontakta kundtjänst."
      And I fill in "Startdag(t.ex. 2018-11-01)" with "2018-01-01"
      And I fill in "Sista dag(t.ex. 2018-12-30)" with "2018-01-20"
      And I fill in "Bruttolön(t.ex. 150)kr/timma" with "100"
      And I click "Anställ"
      And I should see "Grattis! Du har anlitat personen."
      Then I should see "Diskutera & chatta"
      And I should not see "Anställ"
      And I should not see "Skapa faktura baserad på jobbet"
      And I should not see "Jobbet har genomförts!"
      And I click "KONTROLLPANEL"
      Then I should see "Fisken" in active employments
      And I should see "Första jobbdag: 2018-01-01" in active employments
      And I should see "Sista jobbdag: 2018-01-20" in active employments
      And I click "målare sökes"
      And I should see "Anställd!"
      And I click "Visa ansökan"
      And I should see "Diskutera & chatta"
      And I should not see "Jobbet har genomförts!"
      And I should not see "Anställ"
      And I should not see "Skapa faktura baserad på jobbet"
      And the application gets marked as completed
      And I click "KONTROLLPANEL"
      Then I should see "Fisken" in complete employments
      And I should not see "Fisken" in active employments
      And I click "målare sökes"
      Then I should see "Anställd! & jobb genomfört!"
      And I click "LOGGA UT"
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I should see "Anders p skickade ett svar"
      Then I should see "Anders p anställde dig för ansökan"

    Scenario: I hire without adding first day or last day
      Given I am logged in as company "greger@mail.com"
      Given I am on control panel page
      And I click "Visa annons"
      And I should see "Fisken"
      And I click "Visa"
      And I click "Anställ"
      Then I should see "Lön måste fyllas i"
      And I fill in "Bruttolön(t.ex. 150)kr/timma" with "100"
      And I click "Anställ"
      Then I should see "Grattis! Du har anlitat personen."
