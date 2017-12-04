Feature: Post job ad
  As a company
  In order to find workers
  I would like to be able to post a job ad

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
      | Snickare    | 2  |
      | Plåtslagare | 3  |
    Given the following companies exist
      | email          | name | address | zip_code | city | org_number | phone | password  | password_confirmation |
      | felix@mail.com | bill | gatan 3 | 536      | gbgb | 3453324533 | 98789 | 12345678  | 12345678              |

    Scenario: Company tries to post without being logged in
      Given I am on the home page
      And I click "SKAPA ANNONS"
      Then I should see "Du måste logga in eller registrera dig innan du fortsätter."

    Scenario: Company posts an ad
      Given I am on the home page
      Given I am logged in as company "felix@mail.com"
      And I click "SKAPA ANNONS"
      And I should see "Skapa annons"
      And I fill in "Titel" with "målare"
      And I fill in "Beskrivning" with "måla hus"
      And I fill in "Krav" with "inga"
      And I select "Plåtslagare" from "job_category_ids"
      And I select "Göteborg" from "Stad"
      And I fill in "Lön" with "130kr/timma"
      And I fill in "job_deadline" with "2018-02-01"
      And I fill in "Varaktighet" with "5 dagar"
      And I fill in "Timmar" with "30 timmar i veckan"
      And I click "Skapa annons"
      Then I should see "Ny annons skapad!"
      Given I click "KONTROLLPANEL"
      And I should see "målare"
      Then I should not see "Inga jobb hittills"

    Scenario: I post an ad without title
      Given I am on the home page
      Given I am logged in as company "felix@mail.com"
      And I click "SKAPA ANNONS"
      And I should see "Skapa annons"
      And I fill in "Titel" with ""
      And I fill in "Beskrivning" with "måla hus"
      And I fill in "Krav" with "inga"
      And I select "Plåtslagare" from "job_category_ids"
      And I select "Göteborg" from "Stad"
      And I fill in "Lön" with "130kr/timma"
      And I fill in "job_deadline" with "2018-02-01"
      And I fill in "Varaktighet" with "5 dagar"
      And I fill in "Timmar" with "30 timmar i veckan"
      And I click "Skapa annons"
      Then I should see "Titel kan inte vara blankt!"
