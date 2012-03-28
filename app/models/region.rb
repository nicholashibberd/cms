class Region
  include Mongoid::Document
  
  field :name
  field :template
  field :row, :type => Integer
  field :slug
  field :span
  
  belongs_to :page
  has_many :panels
  before_create :generate_slug
  
  scope :by_row, lambda {|row| where(:row => row)}
  
  def generate_slug
    slug = name.gsub("'", "").parameterize
    self.slug = slug
  end
  
  
  def slug
    name.gsub("'", "").parameterize('_')
  end
  
  def self.by_slug(region_slug)
    where(:slug => region_slug).first
  end
  
  def add_panel
    panels.create(:span => span, :page_id => page.id)
  end
        
end