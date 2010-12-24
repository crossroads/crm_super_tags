ActsAsTaggableOn::Tag.class_eval do
  has_many :customfields

  attr_accessible :name, :taggable_type

  # Finds all tags with customfields
  scope :super_tags, where('EXISTS(SELECT * FROM "customfields" WHERE "customfields"."tag_id" = "tags"."id")')

  #~ sortable :by => [ "name ASC", "created_at DESC", "updated_at DESC" ], :default => "name ASC"

  SORT_BY = {
    "name"          => "tags.name ASC",
    "date created"  => "tags.created_at DESC",
    "date updated"  => "tags.updated_at DESC"
  }

  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20              ; end
  def self.outline  ; "long"          ; end
  def self.sort_by  ; "tags.name ASC" ; end

end
