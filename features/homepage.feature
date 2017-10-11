Feature: Homepage

  Scenario: I see some content on homepage
    Given I am on the home page
    Then I should see "GIG"
    And I should see "POST JOB"
    And I should see "FIND FREELANCERS"
    And I should see "FIND A GIG"
    Then I should see "REGISTER"
