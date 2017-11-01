Feature: Homepage

  Scenario: I see some content on homepage
    Given I am on the home page
    Then I should see "GIG"
    And I should see "SKAPA ANNONS"
    And I should see "HITTA FRILANSARE"
    And I should see "HITTA JOBB"
    Then I should see "REGISTRERA"
