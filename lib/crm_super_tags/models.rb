[ Account, Campaign, Contact, Lead, Opportunity ].each do |klass|
  klass.class_eval { include SuperTag }
end
