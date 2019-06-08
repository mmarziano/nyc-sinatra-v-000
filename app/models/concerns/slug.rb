#module Slug
  #module InstanceMethods
    #def slug
      #@slug = self.downcase.split(' ').join('-')
    #end
  #end

  #module ClassMethods
    #def self.find_by_slug(slug)
      #result = self.all.find {|t| t.slug == slug}
    #end
  #end

#end
