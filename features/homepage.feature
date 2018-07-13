Feature: Homepage

  Scenario: I see some content on homepage
    Given I am on the home page
    Then I should see "Jag är en Jobbsökande som letar efter arbete"
    Then I should see "Jag är ett Företag som behöver hjälp"
    And I should see "Hitta Jobb" within freelancer
    And I should see "Hitta Personal" within company
    Then I should see "REGISTRERA KONTO"
    And I click "REGISTRERA FÖRETAG" within section
    Then I should see "Registrera företag"
    And I click "Läs mer om hur det fungerar"
    And I should see "Hur går det till"
    And I click "våra avgifter."
    And I should see "Här förklarar vi i detalj"
    And I click "Så fungerar det" in left menu
    And I click "faktureringen."
    And I should see "Här förklarar vi i detalj"
    And I click "Så fungerar det" in left menu
    And I click "Vi kallar er frilansare! Läs mer om varför här."
    Then I should see "Mer frihet genom frilans"
    And I click "Kontakta oss"
    And I should see "Här kan du kontakta oss"
    And I click "Faktura, avgifter & lön" in left menu
    And I should see "Här förklarar vi i detalj"
    And I click "Användarvillkor" in left menu
    And I should see "Här finner du våra allmänna villkor"
    And I click "Kontakta" in left menu
    Then I should see "Här kan du kontakta oss"
    And I click "Varför frilansare?" in left menu
    Then I should see "Mer frihet genom frilans"
    Given I am on the home page
    And I click "REGISTRERA KONTO" within section
    Then I should see "Registrera nytt konto som jobbsökande"
    Given I am on the home page
    And I click "Hitta Personal" within company
    Then I should see "Registrera företag"
    Given I am on the home page
    And I click "Hitta Jobb" within freelancer
    Then I should see "Alla jobb"
