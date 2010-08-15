@javascript
Feature: Add custom fields to content with super tags
  In order to store extra information on content
  Users
  want to tag content and have custom fields associated

  Scenario: User should be able to edit a super tagged opportunity
    Given a logged in user
    And a tag named "Local Order"
    And a customfield named "Goods purpose"
    And an opportunity named "Refugee housing"
    When I go to the opportunity page
    And I follow "Edit"
    And I fill in "tag1_attributes[goods_purpose]" with "Furnishing appartment"
    And I press "Save Opportunity"
    Then I should see "Furnishing appartment"

  Scenario: User should be able to super tag an opportunity
    Given a logged in user
    And a tag named "Local Order"
    And a customfield named "Goods purpose"
    When I go to the opportunities page
    And I follow "Create Opportunity"
    And I fill in "opportunity[tag_list]" with "Local Order"
    Then I should see "Goods purpose"
