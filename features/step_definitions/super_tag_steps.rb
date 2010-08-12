Given /^a tag named "([^"]+)"$/ do |name|
  @tag = Factory(:tag, :name => name)
end

Given /^a customfield named "([^"]+)"$/ do |name|
  Factory(:customfield, :field_name => name, :tag => @tag)
end

Given /^the following tags:$/ do |tags|
  tags.hashes.each do |tag_hash|
    Factory(:tag, tag_hash)
  end
end

Then /^(?:|I )should not be able to see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_xpath('//*', :text => regexp, :visible => false)
    else
      assert page.has_xpath?('//*', :text => regexp, :visible => false)
    end
  end
end
