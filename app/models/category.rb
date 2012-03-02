class Category
  include Mongoid::Document
  field :name, :type => String
  field :slug
  
  before_create :generate_slug
  has_many :articles
  
  validates_uniqueness_of :name
  
  def to_param
    slug
  end
  
  def self.find_by_slug(slug)
    self.where(:slug => slug).first
  end
  
  def generate_slug
    self.slug = name.gsub("'", "").parameterize
  end
  
  def find_articles_by_month(month)
    articles.desc(:date).select {|a| a.date.strftime('%m-%Y') == month}
  end
  
  def find_limited_articles_by_month(month, count)
    articles = find_articles_by_month(month)
    month ? articles : articles.limit(Integer(count))
  end
  
end
