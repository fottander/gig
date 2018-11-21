Feature: A company hires a person
  As a company
  In order to employ good people again
  I would like to be able to hire poeple whos finished working again

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
      | message    | job_id | profile_username | profile_id | company_id | job_title    | complete | hired | salary | first_day  | last_day   | id |
      | I want job | 1      | Fisken           | 1          | 1          | målare sökes | true     | true  | 150    | 2018-07-02 | 2018-08-01 | 1  |

    Scenario: I hire a profile again
      Given I am logged in as company "greger@mail.com"
      Given I am on control panel page
      And I should not see "Fisken" in active employments
      And I click "Anställ igen"
      And I fill in hidden field start day with "2018-09-01"
      And I fill in hidden field last day with "2018-09-20"
      And I fill in hidden field salary with "100"
      And I click hidden button with id "hire-button"
      Then I should see "Fisken anställdes på nytt"
      And I should see "Fisken" in active employments
      And I should see "2018-09-01" in active employments
      Then I should see "2018-09-20" in active employments
      And I click "LOGGA UT"
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I should see "Anders p har skapat en ny anställning"

    Scenario: I hire a profile again with filling incorrect fields
      Given I am logged in as company "greger@mail.com"
      Given I am on control panel page
      And I should not see "Fisken" in active employments
      And I click "Anställ igen"
      And I fill in hidden field start day with "2018-09-01"
      And I fill in hidden field last day with "2018-09-20"
      And I fill in hidden field salary with ""
      And I click hidden button with id "hire-button"
      Then I should see "Lön måste fyllas i"
      And I should not see "Fisken" in active employments
      And I should not see "2018-09-01" in complete employments
      And I click "Anställ igen"
      And I fill in hidden field start day with "2018-09-01"
      And I fill in hidden field last day with ""
      And I fill in hidden field salary with "100"
      And I click hidden button with id "hire-button"
      Then I should see "Sista dag måste fyllas i"
      And I should not see "Fisken" in active employments
      And I should not see "2018-09-01" in complete employments
      And I click "Anställ igen"
      And I fill in hidden field start day with ""
      And I fill in hidden field last day with "2018-09-20"
      And I fill in hidden field salary with "100"
      And I click hidden button with id "hire-button"
      Then I should see "Startdag måste fyllas i"
      And I should not see "Fisken" in active employments
      And I should not see "2018-09-01" in complete employments
      And I click "Anställ igen"
      And I fill in hidden field start day with "2018-09-01"
      And I fill in hidden field last day with "2018-08-20"
      And I fill in hidden field salary with "100"
      And I click hidden button with id "hire-button"
      Then I should see "Något gick fel. Kontrollera start och sista dag och försök igen eller kontakta kundtjänst."
      And I should not see "Fisken" in active employments
      And I should not see "2018-09-01" in complete employments
