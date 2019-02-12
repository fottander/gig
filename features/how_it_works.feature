Feature: How it works
  As an user
  In order to know how the service works
  I would like to be able to read about the service

  Scenario: I see page
    Given I am on the home page
    And I click "Logga in"
    And I click "som jobbsökare"
    And I click "Läs mer om hur det fungerar"
    Then I should see "Företag skapar en annons"
    Given I am on the home page
    And I click "Hitta Personal"
    And I click "Skapa konto"
    And I click "Läs mer om hur det fungerar"
    Then I should see "Företag skapar en annons"
    Given I am on the home page
    And I click "Logga in"
    And I click "som företag"
    And I click "Läs mer om hur det fungerar"
    Then I should see "Företag skapar en annons"
    Given I am on the home page
    And I click "Logga in"
    And I click "som jobbsökare"
    And I click "Logga in" in actions
    And I click "Läs mer om hur det fungerar"
    Then I should see "Företag skapar en annons"
