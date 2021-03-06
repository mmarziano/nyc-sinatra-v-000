class Title < ActiveRecord::Base
  has_many :figure_titles
  has_many :figures, through: :figure_titles

  def slug
    @slug = self.downcase.split(' ').join('-')
  end
  def self.find_by_slug(slug)
    result = self.all.find {|t| t.slug == slug}
  end
end
