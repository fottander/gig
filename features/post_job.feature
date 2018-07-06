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
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following companies exist
      | email          | username | name | address | zip_code | city | org_number | phone | password  | password_confirmation |
      | felix@mail.com | hello ab | bill | gatan 3 | 536      | gbgb | 3453324533 | 98789 | 12345678  | 12345678              |

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
      And I fill in "Föreslagen lön" with "130kr/timma"
      And I fill in "job_deadline" with "2019-02-01"
      And I fill in "job_when_in_time" with "Så snart som möjligt"
      And I fill in "job_duration" with "5 dagar"
      And I fill in "Timmar" with "8"
      And I click "Skapa annons"
      Then I should see "Ny annons skapad!"
      Given I click "KONTROLLPANEL"
      And I should see "målare"
      Then I should not see "Inga annonser ännu"
      And I click "Visa annons"
      And I should see "målare"
      And I should see "måla hus"
      And I should see "Krav: inga"
      And I should see "Kategorier: Plåtslagare"
      And I should see "Stad: Göteborg"
      And I should see "Föreslagen lön: 130kr/timma"
      And I should see "När ska jobbet utföras: Så snart som möjligt"
      And I should see "Jobbets längd: 5 dagar"
      And I should see "Timmar per dag: 8"
      And I should see "hello ab"
      And I should see "Antal genomförda jobb: 0"
      And I should see "Stad: gbgb"
      And I should see "Inga ansökningar hittills"
      And I should see "Som företag kan du inte ansöka till detta jobbet"

    Scenario: I post an ad without title and succeed without filling budget or deadline or requirement
      Given I am on the home page
      Given I am logged in as company "felix@mail.com"
      And I click "SKAPA ANNONS"
      And I should see "Skapa annons"
      And I fill in "Titel" with ""
      And I fill in "Beskrivning" with "måla hus"
      And I select "Plåtslagare" from "job_category_ids"
      And I select "Göteborg" from "Stad"
      And I fill in "job_when_in_time" with "Så snart som möjligt"
      And I fill in "job_duration" with "5 dagar"
      And I fill in "Timmar" with "8"
      And I click "Skapa annons"
      Then I should see "Titel kan inte vara blankt!"
      And I fill in "Titel" with "Målare"
      And I fill in "Beskrivning" with "måla hus"
      And I select "Plåtslagare" from "job_category_ids"
      And I select "Göteborg" from "Stad"
      And I fill in "job_when_in_time" with "Så snart som möjligt"
      And I fill in "job_duration" with "5 dagar"
      And I fill in "Timmar" with "8"
      And I click "Skapa annons"
      Then I should see "Ny annons skapad!"
      And I click "HITTA JOBB"
      And I click "Ansök"
      And I should see "Föreslagen lön: Ej specificerat"
      And I should see "Krav: Inga krav"
      And I should see deadline two years ahead
