Feature: Contact
  As an user
  In order to get in touch with support
  I would like to send a help message

  Scenario: I send a message
    Given I am on the home page
    And I click "Kontakta oss"
    And I should see "Kontakt"
    And I fill in "* Namn" with "Felix"
    And I fill in "* Email" with "felix.ottander@gmail.com"
    And I fill in "Telefonnummer" with "070444444"
    And I fill in "* Meddelande" with "Hej ge mig hjälp för bövelen!"
    And I click "Skicka"
    Then I should see "Vi har mottagit ditt meddelande och hör av oss så fort vi kan!"
