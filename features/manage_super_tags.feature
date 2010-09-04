@javascript
Feature: Manage custom fields by tag
  In order to add custom fields to Opportunities based on tag
  Admins
  want to be able to manipulate the custom fields associated with a tag

  Scenario: Admin user should see all super tags
    Given a logged in Admin user
    And the following tags:
      |name          |
      |Local Order   |
      |Social Welfare|
    When I go to the admin super tags page
    Then I should see "Local Order"
    And I should see "Social Welfare"

  Scenario: Admin user should be able to create a new super tag
    Given a logged in Admin user
    When I go to the admin super tags page
    And I follow "Create Super Tag"
    When I fill in "acts_as_taggable_on_tag[name]" with "Local Order"
    And I press "Create Super Tag"
    Then I should see "Local Order"

  Scenario: Admin user should be able to edit a super tag
    Given a logged in Admin user
    And a tag named "Local Order"
    When I go to the admin super tags page
    And I move the mouse over "acts_as_taggable_on_tag_1"
    And I follow "Edit"
    And I fill in "acts_as_taggable_on_tag[name]" with "Local Order Updated"
    And I press "Save Super Tag"
    Then I should see "Local Order Updated"

  Scenario: Admin user should be able to view a super tag
    Given a logged in Admin user
    And a tag named "Local Order"
    When I go to the admin super tags page
    And I follow "Local Order"
    Then I should see "Customfields"

  Scenario: Admin user should be able to delete a super tag
    Given a logged in Admin user
    And a tag named "Local Order"
    When I go to the admin super tags page
    And I move the mouse over "acts_as_taggable_on_tag_1"
    And I follow "Delete"
    Then I should not see "Local Order"

  Scenario: Admin user should be able to add a customfield
    Given a logged in Admin user
    And a tag named "Local Order"
    When I go to the admin super tags page
    And I follow "Local Order"
    And I follow "Create Customfield"
    And I fill in the following:
      |customfield[field_name]|goods_purpose|
      |customfield[field_label]|Goods purpose|
      |customfield[max_size]|1024|
      |customfield[display_width]|60|
    And I select "TEXT" from "customfield[field_type]"
    And I press "Create Customfield"
    Then I should see "Goods purpose"

  Scenario: Admin user should be able to edit a customfield
    Given a logged in Admin user
    And a tag named "Local Order"
    And a customfield named "goods_purpose"
    When I go to the admin super tags page
    And I follow "Local Order"
    And I move the mouse over "customfield_1"
    And I follow "Edit" within "#customfield_1"
    And I fill in "customfield[field_name]" with "request_purpose"
    And I press "Save Customfield"
    Then I should see "request_purpose"

  Scenario: Admin user should be able to delete a customfield
    Given a logged in Admin user
    And a tag named "Local Order"
    And a customfield named "goods_purpose"
    When I go to the admin super tags page
    And I follow "Local Order"
    And I move the mouse over "customfield_1"
    And I follow "Delete" within "#customfield_1"
    Then I should not be able to see /goods_purpose/

