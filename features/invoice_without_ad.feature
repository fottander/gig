Feature: Create an invoice without an ad
  As an user
  In order to get paid
  I would like to be able to create an invoice without being connected to an ad

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
      | Snickare    | 2  |
      | Plåtslagare | 3  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
      | Stockholm | 2  |
      | Malmö     | 3  |
    Given the following companies exist
      | email           | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | greger@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following users exist
      | email          | first_name | last_name | password  | password_confirmation | id |
      | felix@mail.com | felix      | ottander  | 12345678  | 12345678              | 1  |
      | greger@mail.com| greger     | stjärtis  | 12345678  | 12345678              | 2  |
    Given the following profiles exist
      | username | description | category_ids | city_ids | user_id | id | age        |
      | Fisken   | målare gbg  | 1            | 1        | 1       | 1  | 1988-09-14 |

  Scenario: I create an invoice without an ad and edit it afterwards and then delete it
    Given I am logged in as user "felix@mail.com"
    Given I am on the dashboards page
    And I click "Fakturera utan företag"
    And I click "Skapa en faktura"
    Then I should see "Här kan du skapa fakturor för jobb du utfört utanför vår plattform"
    And I fill in "* Organisationsnummer" with "324234"
    And I fill in "* Företagsnamn" with "Kul ab"
    And I fill in "* Företagets adress" with "Södra"
    And I fill in "* Postnummer" with "423"
    And I fill in "* Stad" with "Gbg"
    And I fill in "* Email" with "felix@mail.com"
    And I fill in "* Företagsreferens" with "Erik"
    And I fill in "* Beskrivning" with "målning"
    And I fill in "* Antal timmar" with "110"
    And I fill in "* Timlön" with "100"
    And I fill hidden field ez amount and fill "11000"
    And I fill in "* Referens" with "Roger"
    And I click "Skapa"
    Then I should see "Ny faktura skapad!"
    And I click "Fakturera utan företag"
    And I click "Visa/redigera faktura"
    And I should see "Redigera faktura"
    And I fill in "* Antal timmar" with "10"
    And I fill hidden field ez amount and fill "1000"
    And I click "Spara"
    And I click "Fakturera utan företag"
    And I should see "Fakturan ej betald"
    Then I should see "1000"
    And I click "Logga ut"
    Given I am on the admin login page
    And I should see "Logga in som admin"
    And I fill in "Email" with "admin@yahoo.com"
    And I fill in "Lösenord" with "12345678"
    And I click "Logga in" in actions
    Then I should see "Välkommen! Du är inloggad."
    And I click "Snabbfakturor"
    And I click "Visa/godkänn faktura"
    And I should see "Organisationsnummer: 324234"
    And I should see "Företagsnamn: Kul ab"
    And I should see "Adress: Södra"
    And I should see "Postnummer: 423"
    And I should see "Stad: Gbg"
    And I should see "Email: felix@mail.com"
    And I should see "Summa: 1000 SEK"
    And I should see "Bruttolön inkl semesterersättning: 1120 SEK"
    And I should see "Arbetsgivaravgifter: 352 SEK"
    And I should see "Sociala avgifter(4.6%): 52 SEK"
    And I should see "Löneskatt på pensionskostnader: 12 SEK"
    And I should see "Totalsumma ex. moms: 1536"
    And I should see "Totalsumma inkl. moms: 1920"
    And I should see "Beskrivning: målning"
    And I should see "Referens: Roger"
    And I should see "Företagsreferens: Erik"
    And I should see "Frilansar användarnamn: Fisken"
    And I click "Markera som betald"
    And I click "Markera som lön utbetald"
    And I click "Logga ut"
    Given I am logged in as user "felix@mail.com"
    Given I am on the dashboards page
    And I click "Fakturera utan företag"
    Then I should see "Fakturan är betald"
    And I click "Visa utbetalningsinfo"
    And I should see "Nettolön (lön efter skatt): 752 SEK"
    Then I should not see "ej utbetald"

  Scenario: I create an invoice without an ad but without a profile
    Given I am logged in as user "greger@mail.com"
    Given I am on the dashboards page
    And I click "Fakturera utan företag"
    And I click "Skapa en faktura"
    Then I should see "Här kan du skapa fakturor för jobb du utfört utanför vår plattform"
    Then I should see "Skapa en profil innan du kan fakturera!"
