Feature: Commission fee steps
  As an user
  In order to get paid more when earning more
  The system should have a step system for the fee paid by the user

Background:
  Given the following users exist
    | email           | password  | password_confirmation | id |
    | felix@mail.com  | 12345678  | 12345678              | 1  |
  Given the following categories exist
    | name        | id |
    | Målare      | 1  |
  Given the following cities exist
    | name      | id |
    | Göteborg  | 1  |
  Given the following companies exist
    | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
    | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
  Given the following job ads exist
    | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | when_in_time | hour_day | active | company_username | company_city | company_id | id |
    | målare sökes | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | soon         | 8        | true   | Anders p         | Göteborg     | 1          | 1  |
  Given the following profiles exist
    | username | title               | description                                      | skill                      | category_ids | city_ids | id | user_id |
    | fisken   | Erfaren målare      | Erfaren målare och snickare med 5 års erfarenhet | måleri 5 år, snicker 3 år. | 1            | 1        | 1  | 1       |
  Given the following applications exist
    | message    | job_id | profile_username | profile_id | job_title    | hired | complete | id |
    | I want job | 1      | fisken           | 1          | målare sökes | true  | false    | 1  |

  Scenario: I create invioces and my fee lowers
    Given I am logged in as user "felix@mail.com"
    Given I am on the profiles_path
    And I should see "Genomförda jobb: 0"
    Then I should see "Totalt fakturerat: 0 - 10 000 kr"
    And I click "fisken"
    And I should see "Antal genomförda jobb: 0"
    Then I should see "Totalt fakturerat: 0 - 10 000 kr"
    And I click "KONTROLLPANEL"
    And I should see "Totalt fakturerat: 0 kr"
    Then I should see "Din nuvarande avgift är 10.0%. Läs mer om våra avgifter."
    Given I am on the dashboards page
    And I click "Visa ansökan/Skapa faktura"
    And I should see "SKAPA FAKTURA"
    And I fill in "description" with "Hej"
    And I fill in "quantity" with "100"
    And I fill in "unit" with "100"
    And I fill in "amount" with "7000"
    And I fill in "first_day" with "2018-01-01"
    And I fill in "last_day" with "2018-12-12"
    And I fill in "user_reference" with "Felix"
    And I fill in "company_reference" with "Anders"
    And I click "Skapa faktura"
    Then I should see "Faktura skapad"
    And the latest created invoice is beeing activated
    Given I am on the profiles_path
    And I should see "Genomförda jobb: 1"
    Then I should see "Totalt fakturerat: 0 - 10 000 kr"
    And I click "fisken"
    And I should see "Antal genomförda jobb: 1"
    Then I should see "Totalt fakturerat: 0 - 10 000 kr"
    And I click "KONTROLLPANEL"
    And I should see "Totalt fakturerat: 8750 kr"
    Then I should see "Din nuvarande avgift är 10.0%. Läs mer om våra avgifter."
    And I click "Snabbfaktura"
    And I click "Skapa en faktura"
    And I fill in "Organisationsnummer" with "880914"
    And I fill in "Företagsnamn" with "GG"
    And I fill in "Företagets adress" with "Söda"
    And I fill in "Postnummer" with "41267"
    And I fill in "Stad" with "Gbg"
    And I fill in "Email" with "felix@gmail.com"
    And I fill in "Företagsreferens" with "Greger"
    And I fill in "Beskrivning" with "målning"
    And I fill in "* Belopp" with "3000"
    And I fill in "Referens" with "felix"
    And I click "Skapa"
    Then I should see "Ny faktura skapad!"
    And the latest created ezinvoice is beeing activated
    Given I am on the profiles_path
    And I should see "Genomförda jobb: 2"
    Then I should see "Totalt fakturerat: 10 000 - 20 000 kr"
    And I click "fisken"
    And I should see "Antal genomförda jobb: 2"
    Then I should see "Totalt fakturerat: 10 000 - 20 000 kr"
    And I click "KONTROLLPANEL"
    And I should see "Totalt fakturerat: 12500 kr"
    Then I should see "Din nuvarande avgift är 9.0%. Läs mer om våra avgifter."
    And an invoice with amount "4000" is created and activated
    Given I am on the profiles_path
    And I should see "Genomförda jobb: 3"
    Then I should see "Totalt fakturerat: 10 000 - 20 000 kr"
    And I click "fisken"
    And I should see "Antal genomförda jobb: 3"
    Then I should see "Totalt fakturerat: 10 000 - 20 000 kr"
    And I click "KONTROLLPANEL"
    And I should see "Totalt fakturerat: 17500 kr"
    Then I should see "Din nuvarande avgift är 9.0%. Läs mer om våra avgifter."
    And an invoice with amount "8000" is created and activated
    Given I am on the profiles_path
    And I should see "Genomförda jobb: 4"
    Then I should see "Totalt fakturerat: 20 000 - 50 000 kr"
    And I click "fisken"
    And I should see "Antal genomförda jobb: 4"
    Then I should see "Totalt fakturerat: 20 000 - 50 000 kr"
    And I click "KONTROLLPANEL"
    And I should see "Totalt fakturerat: 27500 kr"
    Then I should see "Din nuvarande avgift är 8.0%. Läs mer om våra avgifter."
    And an invoice with amount "40000" is created and activated
    Given I am on the profiles_path
    And I should see "Genomförda jobb: 5"
    Then I should see "Totalt fakturerat: 50 000 - 100 000 kr"
    And I click "fisken"
    And I should see "Antal genomförda jobb: 5"
    Then I should see "Totalt fakturerat: 50 000 - 100 000 kr"
    And I click "KONTROLLPANEL"
    And I should see "Totalt fakturerat: 77500 kr"
    Then I should see "Din nuvarande avgift är 7.0%. Läs mer om våra avgifter."
    And an invoice with amount "40000" is created and activated
    Given I am on the profiles_path
    And I should see "Genomförda jobb: 6"
    Then I should see "Totalt fakturerat: 100 000 - 250 000 kr"
    And I click "fisken"
    And I should see "Antal genomförda jobb: 6"
    Then I should see "Totalt fakturerat: 100 000 - 250 000 kr"
    And I click "KONTROLLPANEL"
    And I should see "Totalt fakturerat: 127500 kr"
    Then I should see "Din nuvarande avgift är 6.0%. Läs mer om våra avgifter."
    And an invoice with amount "160000" is created and activated
    Given I am on the profiles_path
    And I should see "Genomförda jobb: 7"
    Then I should see "Totalt fakturerat: 250 000 - 500 000 kr"
    And I click "fisken"
    And I should see "Antal genomförda jobb: 7"
    Then I should see "Totalt fakturerat: 250 000 - 500 000 kr"
    And I click "KONTROLLPANEL"
    And I should see "Totalt fakturerat: 327500 kr"
    Then I should see "Din nuvarande avgift är 5.0%. Läs mer om våra avgifter."
    And an invoice with amount "160000" is created and activated
    Given I am on the profiles_path
    And I should see "Genomförda jobb: 8"
    Then I should see "Totalt fakturerat: Mer än 500 000 kr"
    And I click "fisken"
    And I should see "Antal genomförda jobb: 8"
    Then I should see "Totalt fakturerat: Mer än 500 000 kr"
    And I click "KONTROLLPANEL"
    And I should see "Totalt fakturerat: 527500 kr"
    Then I should see "Din nuvarande avgift är 4.0%. Läs mer om våra avgifter."
