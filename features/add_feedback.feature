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
      | email          | first_name | last_name | password  | password_confirmation | id   |
      | felix@mail.com | felix      | ottander  | 12345678  | 12345678              | 9999 |
    Given the following profiles exist
      | username | description | category_ids | city_ids | user_id | id   | age        |
      | Fisken   | målare gbg  | 1            | 1        | 9999    | 9999 | 1988-09-14 |
    Given the following invoices exist
      | description | quantity | unit| amount | user_reference | terms |id | company_id | user_id | profile_id | job_id | job_title    | paid  | rating |
      | ref         | 100      | 12  | 1200   | felix          | 10    | 1 | 1          | 9999    | 9999       | 1      | Målare sökes | true  |        |
      | fer         | 100      | 12  | 1200   | felix          | 10    | 2 | 1          | 9999    | 9999       | 1      | Målare sökes | true  | 5      |
      | tyr         | 100      | 12  | 1200   | felix          | 10    | 3 | 1          | 9999    | 9999       | 1      | Målare sökes | true  | 3      |
      | abc         | 100      | 12  | 1200   | felix          | 10    | 4 | 1          | 9999    | 9999       | 1      | Målare sökes | false |        |

    Scenario: I give feedback with extended post, terms and rating
      Given I am logged in as user "felix@mail.com"
      Given I am on the home page
      And I click "ALLA JOBBSÖKARE"
      And I click "Fisken"
      And I should not see "Betyg"
      And I click "LOGGA UT"
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Antal timmar: 100.0st"
      And I should see "Timlön: 12kr/timma"
      And I should see "Bruttolön: 1200"
      And I should see "Bruttolön inkl semesterersättning(12%): 1344"
      And I should see "Arbetsgivaravgifter(31,42%): 422"
      And I should see "Sociala avgifter(0.3%): 4"
      And I should see "Belopp ex. moms: 1770"
      And I should see "Belopp inkl. moms: 2213"
      And I should see "Fakturaavgifter: 199"
      And I should see "Totalsumma exkl. moms: 1969"
      And I should see "Totalsumma inkl. moms: 2461"
      And I should see "Rekommendera MyString till andra"
      And I should see "Ge betyg till MyString"
      And I fill in "feedback" with "Väldigt bra snubbe"
      And I click "Skicka feedback"
      And I should see "Sparat!"
      And I select "5" from "rating"
      And I click "Skicka betyg"
      And I should see "Sparat!"
      And I click "LOGGA UT"
      Given I am logged in as user "felix@mail.com"
      Given I am on the home page
      And I click "ALLA JOBBSÖKARE"
      And I click "Fisken"
      And I should see "Betyg 5/5"
      And I should see "Betyg 4.3/5"
      Then I should see "Väldigt bra snubbe"
      And I click "LOGGA UT"
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "KONTROLLPANEL"
      And I click "Visa/Kontrollera"
      And I should see "Belopp ex. moms: 1770"
      And I should see "Belopp inkl. moms: 2213"
      And I should see "Fakturaavgifter: -1"
      And I should see "Totalsumma exkl. moms: 1769"
      And I should see "Totalsumma inkl. moms: 2211"
      And I should not see "Rekommendera MyString till andra"
      And I should not see "Ge betyg till MyString"
      And I click "Lägg till" terms button
      And I should not see "Klicka för 30 dagars fakturatid(+500kr)"
      And I should see "Belopp ex. moms: 1770"
      And I should see "Belopp inkl. moms: 2213"
      And I should see "Fakturaavgifter: 499"
      And I should see "Totalsumma exkl. moms: 2269"
      And I should see "Totalsumma inkl. moms: 2836"
      And I click "Lägg till" post button
      And I should not see "Klicka för att få fakturan på posten(+40kr)"
      And I should see "Belopp ex. moms: 1770"
      And I should see "Belopp inkl. moms: 2213"
      And I should see "Fakturaavgifter: 539"
      And I should see "Totalsumma exkl. moms: 2309"
      And I should see "Totalsumma inkl. moms: 2886"

    Scenario: I give feedback with extended post, terms and rating in a different order
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Belopp ex. moms: 1770"
      And I should see "Belopp inkl. moms: 2213"
      And I should see "Fakturaavgifter: 199"
      And I should see "Totalsumma exkl. moms: 1969"
      And I should see "Totalsumma inkl. moms: 2461"
      And I should see "Rekommendera MyString till andra"
      And I should see "Ge betyg till MyString"
      And I click "Lägg till" terms button
      And I should not see "Klicka för 30 dagars fakturatid(+500kr)"
      And I should see "Belopp ex. moms: 1770"
      And I should see "Belopp inkl. moms: 2213"
      And I should see "Fakturaavgifter: 699"
      And I should see "Totalsumma exkl. moms: 2469"
      And I should see "Totalsumma inkl. moms: 3086"
      And I click "Lägg till" post button
      And I should not see "Klicka för att få fakturan på posten(+40kr)"
      And I should see "Belopp ex. moms: 1770"
      And I should see "Belopp inkl. moms: 2213"
      And I should see "Fakturaavgifter: 739"
      And I should see "Totalsumma exkl. moms: 2509"
      And I should see "Totalsumma inkl. moms: 3136"
      And I select "5" from "rating"
      And I click "Skicka betyg"
      And I should see "Sparat!"
      And I fill in "feedback" with "Väldigt bra snubbe"
      And I click "Skicka feedback"
      And I should see "Sparat!"
      And I click "LOGGA UT"
      Given I am logged in as user "felix@mail.com"
      Given I am on the home page
      And I click "ALLA JOBBSÖKARE"
      And I click "Fisken"
      And I should see "5/5"
      Then I should see "Väldigt bra snubbe"
      And I click "LOGGA UT"
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "KONTROLLPANEL"
      And I click "Visa/Kontrollera"
      And I should see "Belopp ex. moms: 1770"
      And I should see "Belopp inkl. moms: 2213"
      And I should see "Fakturaavgifter: 539"
      And I should see "Totalsumma exkl. moms: 2309"
      And I should see "Totalsumma inkl. moms: 2886"
      And I should not see "Rekommendera MyString till andra"
      And I should not see "Ge betyg till MyString"
