@javascript
Feature: Add custom fields to content with super tags
  In order to store extra information on content
  Users
  want to tag content and have custom fields associated

  Scenario: User should be able to edit a super tagged opportunity
    Given a logged in user
    And a tag named "Local Order"
    And the tag has a customfield named "Goods purpose"
    And an opportunity named "Refugee housing"
    And the opportunity is tagged with "Local Order"
    When I go to the opportunity page
    And I follow "Edit"
    And I fill in "Goods purpose:" with "Furnishing apartment"
    And I press "Save Opportunity"
    Then I should not see "Edit Refugee housing"
    When I follow "Edit"
    Then the "Goods purpose:" field should contain "Furnishing apartment"

  Scenario: Super tag fields should be AJAX loaded when the tags input is changed
    Given a logged in user
    And a tag named "Local Order"
    And the tag has a customfield named "Goods purpose"
    And an opportunity named "Refugee housing"
    When I go to the opportunity page
    And I follow "Edit"
    Then I should see "(comma separated, letters and digits only)"
    And I fill in "fblist-maininput" with "Local Order," within "#facebook-list"
    And I emulate a separator keypress on the facebook tag list
    And I fill in "fblist-maininput" with "a normal tag," within "#facebook-list"
    And I emulate a separator keypress on the facebook tag list   
    Then I should see "Goods purpose:"
    When I fire the "click" event on css selector "#facebook-list a.closebutton"[0]
    And I fill in "fblist-maininput" with "another normal tag," within "#facebook-list"
    Then I should not see "Custom fields for Local Order"

  Scenario: User should be able to create a new opportunity with AJAX loaded supertag fields
    Given a logged in user
    And a tag named "Local Order"
    And the tag has a customfield named "Goods purpose"
    When I go to the opportunities page
    And I follow "Create Opportunity"
    And I fill in "opportunity_name" with "Local Order #L4345"
    And I follow "create new" within "#account_select_title"
    And I fill in "account_name" with "A Social Welfare Organisation"
    And I fill in "fblist-maininput" with "Local Order," within "#facebook-list"
    And I emulate a separator keypress on the facebook tag list
    And I fill in "fblist-maininput" with "a normal tag," within "#facebook-list"
    And I emulate a separator keypress on the facebook tag list
    Then I should see "Goods purpose:"
    When I fill in "Goods purpose:" with "Furnishing apartment"
    And I press "Create Opportunity"
    Then I should see "Local Order #L4345"

  Scenario: When a new opportunity fails validation, supertag fields should still be shown
    Given a logged in user
    And a tag named "Local Order"
    And the tag has a customfield named "Goods purpose"
    When I go to the opportunities page
    And I follow "Create Opportunity"
    And I fill in "opportunity_name" with ""
    And I fill in "fblist-maininput" with "Local Order," within "#facebook-list"
    And I emulate a separator keypress on the facebook tag list
    And I fill in "fblist-maininput" with "another tag," within "#facebook-list"
    And I emulate a separator keypress on the facebook tag list 
    Then I should see "Goods purpose:"
    When I fill in "Goods purpose:" with "Furnishing apartment"
    And I press "Create Opportunity"
    Then I should see "Please specify opportunity name."
    And I should see "Local Order" within "#super_tags"

