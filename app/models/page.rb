class Page 
  include Mongoid::Document 
  
  field :name, :type => String
  field :slug, :type => String
  field :title, :type => String
  field :template
  #field :panels, :type => Integer, :default => 1
  field :header

  has_many :regions  
  has_many :panels
  has_many :widgets  
  has_and_belongs_to_many :photos
  belongs_to :group
  
  before_create :generate_slug
  validates_presence_of :name
  
  scope :top_level, where(:group_id => nil)
  
  def generate_slug
    new_slug = name.gsub("'", "").parameterize
    group_slug = group_id ? "#{group.slug}-#{new_slug}" : new_slug
    self.slug = group_slug
  end
  
  def to_param
    slug
  end

  def self.find_by_slug(slug)
    slug ? self.where(:slug => slug).first : Site.instance.homepage
  end
  
  def page_type
    self._type ? self._type.underscore : 'page'
  end
    
  # Widgets
  def find_widget(widget_id)
    widgets.select {|widget| widget.id.to_s == widget_id}.first
  end
  
  def add_widget(params)
    widget_type = params[:widget_type]
    widget_class = widget_type.classify.constantize
    widgets << widget_class.new(params[widget_type])
  end
  
  def update_widget(params)    
    widget_type = params[:widget_type]
    @widget = find_widget(params[:id])
    @widget.update_attributes(params[widget_type])
  end
  
  # Regions
  
  def save_regions(page_regions)
    regions.clear
    page_regions.each do |region|
      regions << Region.new(:name => region['name'], :panels => region['panels'].values)
    end
    save
  end
  
end