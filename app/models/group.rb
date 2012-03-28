class Group 
  include Mongoid::Document
  
  field :name
  field :slug
  field :homepage_id
  
  has_many :pages
  has_many :nav_menus
  has_many :events
  has_many :event_series
  has_many :articles
  has_many :photos
  has_many :forms
  has_many :documents
  has_many :people
  
  validates_uniqueness_of :name
  before_create :generate_slug
  
  def generate_slug
    self.slug = name.gsub("'", "").parameterize
  end

  def to_param
    slug
  end
  
  def self.find_by_slug(slug)
    self.where(:slug => slug).first
  end
  
  def find_page(id)
    pages.select {|page| page.slug == id}.first``
  end
  
  def homepage
    homepage_id ? Page.find(homepage_id) : pages.first
  end

end