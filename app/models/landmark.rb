class Landmark < ActiveRecord::Base
  belongs_to :figure
  

  def slug
    @slug = self.downcase.split(' ').join('-')
  end
  def self.find_by_slug(slug)
    result = self.all.find {|t| t.slug == slug}
  end
end
