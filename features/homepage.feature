Feature: Homepage

  Scenario: I see some content on homepage
    Given I am on the home page
    Then I should see "Jag är en Arbetsökande som letar efter jobb"
    Then I should see "Jag är ett Företag som behöver hjälp"
    And I should see "Hitta Jobb" within freelancer
    And I should see "Hitta Arbetskraft" within company
    Then I should see "REGISTRERA"
    And I click "REGISTRERA FÖRETAG" within section
    Then I should see "Registrera företag"
    Given I am on the home page
    And I click "REGISTRERA FRILANSARE" within section
    Then I should see "Registrera ny frilansare"
    Given I am on the home page
    And I click "Hitta Arbetskraft" within company
    Then I should see "Registrera företag"
    Given I am on the home page
    And I click "Hitta Jobb" within freelancer
    Then I should see "Alla jobb"
