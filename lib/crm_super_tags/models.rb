require File.join(File.dirname(__FILE__), 'super_tag')

[ Account, Campaign, Contact, Lead, Opportunity ].each do |klass|
  klass.class_eval do
    include SuperTag
    def customfields
      self.tags.inject({}){|r, t| r[t.name] = self.send("tag#{t.id}"); r }
    end
  end
end
