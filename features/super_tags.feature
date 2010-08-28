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
    And the opportunity is tagged with "Local Order"
    When I go to the opportunity page
    And I follow "Edit"
    And I follow "Local Order" within "#edit_opportunity"
    And I fill in "Goods purpose:" with "Furnishing appartment"
    And I press "Save Opportunity"
    Then I should not see "Edit Refugee housing"
    When I follow "Edit"
    Then the "Goods purpose:" field should contain "Furnishing appartment"

  Scenario: Super tag fields should be AJAX loaded when the tags input is changed
    Given a logged in user
    And a tag named "Local Order"
    And a customfield named "Goods purpose"
    And an opportunity named "Refugee housing"
    When I go to the opportunity page
    And I follow "Edit"
    And I fill in "opportunity_tag_list" with "normal tag, Local Order"
    And I fire the "change" event on "opportunity_tag_list"
    Then I should see "Custom fields for Local Order"
    When I follow "Local Order" within "#edit_opportunity"
    Then I should see "Goods purpose:"
    When I fill in "opportunity_tag_list" with "normal tag, another un-super tag"
    And I fire the "change" event on "opportunity_tag_list"
    Then I should not see "Custom fields for Local Order"

  Scenario: User should be able to create a new opportunity with AJAX loaded supertag fields
    Given a logged in user
    And a tag named "Local Order"
    And a customfield named "Goods purpose"
    When I go to the opportunities page
    And I follow "Create Opportunity"
    And I fill in "opportunity_name" with "Local Order #L4345"
    And I fill in "opportunity_tag_list" with "normal tag, Local Order"
    And I fire the "change" event on "opportunity_tag_list"
    And I fire the "click" event on css selector "#super_tags .subtitle a"
    And I fill in "Goods purpose:" with "Furnishing appartment"
    And I press "Create Opportunity"
    Then I should see "Local Order #L4345"

  Scenario: When a new opportunity fails validation, supertag fields should still be shown
    Given a logged in user
    And a tag named "Local Order"
    And a customfield named "Goods purpose"
    When I go to the opportunities page
    And I follow "Create Opportunity"
    And I fill in "opportunity_tag_list" with "normal tag, Local Order"
    And I fire the "change" event on "opportunity_tag_list"
    And I fire the "click" event on css selector "#super_tags .subtitle a"
    And I fill in "Goods purpose:" with "Furnishing appartment"
    And I press "Create Opportunity"
    Then I should see "Please specify opportunity name."
    And I should see "Local Order" within "#super_tags"

