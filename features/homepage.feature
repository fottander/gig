Feature: Homepage

  Scenario: I see some content on homepage
    Given I am on the home page
    Then I should see "Jag är en Jobbsökande som letar efter arbete"
    Then I should see "Jag är ett Företag som behöver hjälp"
    And I should see "Hitta Jobb" within freelancer
    And I should see "Hitta Personal" within company
    Then I should see "Registrera konto"
    And I click "Registrera företag" within section
    Then I should see "Registrera nytt företag"
    And I click "Läs mer om hur det fungerar"
    And I should see "Hur går det till"
    And I click "våra avgifter."
    And I should see "Här förklarar vi i detalj"
    And I click "Så fungerar det" in left menu
    And I click "faktureringen."
    And I should see "Här förklarar vi i detalj"
    And I click "Så fungerar det" in left menu
    And I click "Varför ska du använda Qnekt? Läs mer här."
    Then I should see "Varför Qnekt?"
    And I click "Vanliga frågor" in left menu
    And I should see "Här har vi samlat de vanligaste frågorna"
    And I click "Kontakta" in left menu
    And I should see "Här kan du kontakta oss"
    And I click "Faktura, avgifter & lön" in left menu
    And I should see "Här förklarar vi i detalj"
    And I click "Användarvillkor" in left menu
    And I should see "Här finner du våra allmänna villkor"
    And I click "Kontakta" in left menu
    Then I should see "Här kan du kontakta oss"
    And I click "Varför Qnekt?" in left menu
    Then I should see "Varför Qnekt?"
    Given I am on the home page
    And I click "Registrera konto" within section
    Then I should see "Registrera nytt konto som jobbsökande"
    Given I am on the home page
    And I click "Hitta Personal" within company
    And I click "Skapa konto"
    Then I should see "Registrera nytt företag"
    Given I am on the home page
    And I click "Hitta Jobb" within freelancer
    Then I should see "Alla jobb"
