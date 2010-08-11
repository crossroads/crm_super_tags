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
