Feature: Homepage

  Scenario: I see some content on homepage
    Given I am on the home page
    Then I should see "SÖK JOBB. SÖK ARBETSKRAFT."
    And I should see "SKAPA ANNONS"
    And I should see "HITTA FRILANSARE"
    And I should see "HITTA JOBB"
    Then I should see "REGISTRERA"
    And I click "FÖRETAG" within section
    Then I should see "Registrera företag"
    Given I am on the home page
    And I click "FRILANSARE" within section
    Then I should see "Registrera ny frilansare"
    Given I am on the home page
    And I click "FÖRETAG" within hero
    Then I should see "Registrera företag"
    Given I am on the home page
    And I click "FRILANSARE" within hero
    Then I should see "Registrera ny frilansare"
