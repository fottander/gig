Feature: Post job ad
  As a company
  In order to find workers
  I would like to be able to post a job ad

  Background:
    Given the following companies exist
      | email          | name | address | zip_code | city | org_number | phone | password  | password_confirmation |
      | felix@mail.com | bill | gatan 3 | 536      | gbgb | 3453324533 | 98789 | 12345678  | 12345678              |

    Scenario: Company tries to post without being logged in
      Given I am on the home page
      And I click "SKAPA ANNONS"
      Then I should see "You need to sign in or sign up before continuing."

    Scenario: Company posts an ad
      Given I am on the home page
      Given I am logged in as company "felix@mail.com"
      And I click "SKAPA ANNONS"
      And I should see "Skapa annons"
      And I fill in "Titel" with "målare"
      And I fill in "Beskrivning" with "måla hus"
      And I fill in "Krav" with "inga"
      And I select "Målare" from "Kategori"
      And I select "Göteborg" from "Stad"
      And I fill in "Lön" with "130kr/timma"
      And I fill in "Sista anmälningsdag" with "2018-10-10"
      And I fill in "Varaktighet" with "5 dagar"
      And I fill in "Timmar" with "30 timmar i veckan"
      And I click "Skapa annons"
      Then I should see "New job created!"
      Given I click "KONTROLLPANEL"
      And I should see "målare"
      Then I should not see "No jobs yet"
