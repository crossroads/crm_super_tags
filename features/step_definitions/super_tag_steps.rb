Given /^a tag named "([^"]+)"$/ do |name|
  @tag = Factory(:tag, :name => name)
end

Given /^the tag has a customfield named "([^"]+)"$/ do |name|
  Factory(:customfield, :field_name => name.downcase.gsub(' ', '_'),
                        :field_label => name,
                        :field_type => 'VARCHAR(255)',
                        :form_field_type => 'short_answer',
                        :tag => @tag)
end

Given /^the following tags:$/ do |tags|
  tags.hashes.each do |tag_hash|
    Factory(:tag, tag_hash)
  end
end

And /^the opportunity is tagged with "([^"]*)"$/ do |tag_name|
  @opportunity.update_attribute(:tag_list, tag_name)
end

Then /^(?:|I )should not be able to see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if page.respond_to? :should
      page.should_not have_xpath('//*', :text => regexp, :visible => false)
    else
      assert !page.has_xpath?('//*', :text => regexp, :visible => false)
    end
  end
end

And /^I emulate a separator keypress on the facebook tag list$/ do
  index ||= 0
  begin
    Capybara.current_session.driver.browser.execute_script("fbtaglist.fireSeparatorEvent();")
  rescue Capybara::NotSupportedByDriverError
  end
end
