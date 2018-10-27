Feature: Without kollektivavtal
  As a company
  In order to be able to hire people with kollektivavtal
  The system should be able to handle different kollektivavtal.

Background:
  Given the following admins exist
    | email           | password  | password_confirmation |
    | admin@yahoo.com | 12345678  | 12345678              |
  Given the following users exist
    | email           | password  | password_confirmation | id | first_name | last_name | pers_num   | bank | clear_nr | account_nr |
    | fisken@mail.com | 12345678  | 12345678              | 1  | fisken     | ottander  | 9809141111 | nord | 3000     | 88888888   |
    | felix@mail.com  | 12345678  | 12345678              | 2  | felix      | ottander  | 8809141111 | nord | 3000     | 88888888   |
    | johan@mail.com  | 12345678  | 12345678              | 3  | johan      | ottander  | 4809141111 | nord | 3000     | 88888888   |
  Given the following categories exist
    | name   | id |
    | Måleri | 1  |
  Given the following cities exist
    | name     | id |
    | Göteborg | 1  |
  Given the following profiles exist
    | username | title               | description                                      | skill                      | category_ids | city_ids | id | user_id | age        |
    | fisken   | Erfaren målare      | Erfaren målare och snickare med 5 års erfarenhet | måleri 5 år, snicker 3 år. | 1            | 1        | 1  | 1       | 1998-01-14 |
    | felix    | Erfaren snickare    | Erfaren målare och snickare med 5 års erfarenhet | måleri 5 år, snicker 3 år. | 1            | 1        | 2  | 2       | 1988-01-14 |
    | johan    | Erfaren plåtis      | Erfaren målare och snickare med 5 års erfarenhet | måleri 5 år, snicker 3 år. | 1            | 1        | 3  | 3       | 1948-01-14 |
  Given the following companies exist
    | email           | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
    | fisken@mail.com | bill | Anders a | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    | felix@mail.com  | bill | Anders b | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 2  |
    | johan@mail.com  | bill | Anders c | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 3  |
  Given the following invoices exist
    | description     | amount | user_reference | terms |id | company_id | user_id | job_id | job_title      | paid  | salary_paid | soc_avgift | age | updated_at | profile_id | profile_username |
    | fisken fakturan | 1000   | fisken         | 15    | 1 | 1          | 1       | 1      | Målare sökes   | true  | true        | 0.046      | 20  | 2018-01-01 | 1          | fisken           |
    | felix fakturan  | 1000   | felix          | 15    | 2 | 2          | 2       | 2      | Snickare sökes | true  | true        | 0.046      | 30  | 2018-01-01 | 2          | felix            |
    | johan fakturan  | 1000   | johan          | 15    | 3 | 3          | 3       | 3      | Plåtis sökes   | true  | true        | 0.046      | 70  | 2018-01-01 | 3          | johan            |

  Scenario: I see the invoices for under 25 without kollektivavtal
    Given I am logged in as user "fisken@mail.com"
    Given I am on the dashboards page
    And I click "Visa"
    And I should not see "pensionsinbetalning"
    Then I should see "Lön som betalas ut: 706 SEK"
    And I click "Utbetalningar"
    And I click "2018-01-01 00:00"
    And I should see "Bruttolön: 1000"
    And I should see "Bruttolön inkl. semesterersättning(12%): 1120"
    And I should see "Vår avgift: -112"
    And I should see "Ny bruttolön inkl sem. ers: 1008 SEK"
    And I should see "Skatt: -302 SEK"
    And I should see "Utbetald summa: 706 SEK"
    And I should not see "pensionsinbetalning"
    And I should see "Sociala avgifter(0.3%): 3 SEK"
    And I click "LOGGA UT"
    Given I am logged in as company "fisken@mail.com"
    Given I am on control panel page
    And I click "Visa"
    And I should see "Bruttolön: 1000"
    And I should see "Bruttolön inkl semesterersättning(12%): 1120"
    And I should see "Arbetsgivaravgifter(31,42%): 352"
    And I should see "Sociala avgifter(0.3%): 3"
    And I should see "Belopp ex. moms: 1475"
    And I click "LOGGA UT"
    Given I am logged in as admin "admin@yahoo.com"
    Given I am on the administrations page
    And I click "Fakturor"
    And I fill in "with_company_id" with "1"
    And I click "Sök"
    And I click "Visa/godkänn faktura"
    And I should see "Summa: 1000 SEK"
    And I should see "Bruttolön inkl semesterersättning: 1120 SEK"
    And I should see "Arbetsgivaravgifter: 352 SEK"
    And I should see "Sociala avgifter(0.3%): 3 SEK"
    And I should see "Löneskatt på pensionskostnader: 0 SEK"
    And I should see "Summa ex. moms: 1475"
    And I should see "User fee: 0.1"
    And I should see "Fakturabelopp exkl moms: 1475"
    And I should see "Vår avgift: -147 SEK"
    And I should see "Arbetsgivaravgifter(31,42%): -317 SEK"
    And I should see "Sociala avgifter(0.3%): 3 SEK"
    And I should not see "pensionsinbetalning"
    And I should see "Bruttolön inkl sem. ers: 1008 SEK"
    And I should see "Skatt: -302 SEK"
    And I should see "Nettolön att utbetala: 706 SEK"

  Scenario: I see the invoices for 25-65 without kollektivavtal
    Given I am logged in as user "felix@mail.com"
    Given I am on the dashboards page
    And I click "Visa"
    And I should see "Varav pensionsinbetalning: 43 SEK"
    Then I should see "Lön som betalas ut: 706 SEK"
    And I click "Utbetalningar"
    And I click "2018-01-01 00:00"
    And I should see "Bruttolön: 1000"
    And I should see "Bruttolön inkl. semesterersättning(12%): 1120"
    And I should see "Vår avgift: -112"
    And I should see "Ny bruttolön inkl sem. ers: 1008 SEK"
    And I should see "Skatt: -302 SEK"
    And I should see "Utbetald summa: 706 SEK"
    And I should see "Arbetsgivaravgifter(31,42%): 317 SEK"
    And I should see "Sociala avgifter(4.6%): 46 SEK"
    And I should see "Varav pensionsinbetalning: 43 SEK"
    And I click "LOGGA UT"
    Given I am logged in as company "felix@mail.com"
    Given I am on control panel page
    And I click "Visa"
    And I should see "Bruttolön: 1000"
    And I should see "Bruttolön inkl semesterersättning(12%): 1120"
    And I should see "Arbetsgivaravgifter(31,42%): 352"
    And I should see "Sociala avgifter(4.6%): 52"
    And I should see "Löneskatt på pensionskostnader: 12"
    And I should see "Belopp ex. moms: 1536"
    And I click "LOGGA UT"
    Given I am logged in as admin "admin@yahoo.com"
    Given I am on the administrations page
    And I click "Fakturor"
    And I fill in "with_company_id" with "2"
    And I click "Sök"
    And I click "Visa/godkänn faktura"
    And I should see "Summa: 1000 SEK"
    And I should see "Bruttolön inkl semesterersättning: 1120 SEK"
    And I should see "Arbetsgivaravgifter: 352 SEK"
    And I should see "Sociala avgifter(4.6%): 52 SEK"
    And I should see "Löneskatt på pensionskostnader: 12 SEK"
    And I should see "Summa ex. moms: 1536"
    And I should see "User fee: 0.1"
    And I should see "Fakturabelopp exkl moms: 1536"
    And I should see "Vår avgift: -147 SEK"
    And I should see "Arbetsgivaravgifter(31,42%): -317 SEK"
    And I should see "Sociala avgifter(4.6%): -46 SEK"
    And I should see "Varav pensionsinbetalning: 43 SEK"
    And I should see "Bruttolön inkl sem. ers: 1008 SEK"
    And I should see "Skatt: -302 SEK"
    And I should see "Nettolön att utbetala: 706 SEK"

  Scenario: I see the invoices for over 65 without kollektivavtal
    Given I am logged in as user "johan@mail.com"
    Given I am on the dashboards page
    And I click "Visa"
    And I should not see "pensionsinbetalning"
    Then I should see "Lön som betalas ut: 706 SEK"
    And I click "Utbetalningar"
    And I click "2018-01-01 00:00"
    And I should see "Bruttolön: 1000"
    And I should see "Bruttolön inkl. semesterersättning(12%): 1120"
    And I should see "Vår avgift: -112"
    And I should see "Ny bruttolön inkl sem. ers: 1008 SEK"
    And I should see "Skatt: -302 SEK"
    And I should see "Utbetald summa: 706 SEK"
    And I should not see "pensionsinbetalning"
    And I should see "Sociala avgifter(0.3%): 3 SEK"
    And I click "LOGGA UT"
    Given I am logged in as company "johan@mail.com"
    Given I am on control panel page
    And I click "Visa"
    And I should see "Bruttolön: 1000"
    And I should see "Bruttolön inkl semesterersättning(12%): 1120"
    And I should see "Arbetsgivaravgifter(31,42%): 352"
    And I should see "Sociala avgifter(0.3%): 3"
    And I should see "Belopp ex. moms: 1475"
    And I click "LOGGA UT"
    Given I am logged in as admin "admin@yahoo.com"
    Given I am on the administrations page
    And I click "Fakturor"
    And I fill in "with_company_id" with "3"
    And I click "Sök"
    And I click "Visa/godkänn faktura"
    And I should see "Summa: 1000 SEK"
    And I should see "Bruttolön inkl semesterersättning: 1120 SEK"
    And I should see "Arbetsgivaravgifter: 352 SEK"
    And I should see "Sociala avgifter(0.3%): 3 SEK"
    And I should see "Löneskatt på pensionskostnader: 0 SEK"
    And I should see "Summa ex. moms: 1475"
    And I should see "User fee: 0.1"
    And I should see "Fakturabelopp exkl moms: 1475"
    And I should see "Vår avgift: -147 SEK"
    And I should see "Arbetsgivaravgifter(31,42%): -317 SEK"
    And I should see "Sociala avgifter(0.3%): 3 SEK"
    And I should not see "pensionsinbetalning"
    And I should see "Bruttolön inkl sem. ers: 1008 SEK"
    And I should see "Skatt: -302 SEK"
    And I should see "Nettolön att utbetala: 706 SEK"
