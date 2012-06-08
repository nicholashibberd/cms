class Region
  include Mongoid::Document
  default_scope asc(:position)
  
  field :template
  field :row, :type => Integer
  field :span
  field :flexible, :type => Boolean, :default => false
  field :sub_region, :type => Hash
  field :region_type
  field :region_category
  field :position
  field :name
  
  belongs_to :html_page
  belongs_to :region
  has_many :rows
  has_many :panels
  has_many :regions
  
  before_create :set_position, :set_name
  
  scope :by_row, lambda {|row| where(:row => row)}
  scope :by_type, lambda {|region_type| where(:region_type => region_type)}
  scope :by_category, lambda {|region_category| where(:region_category => region_category)}
  scope :top_level, where(:region_id => nil)  
  
  def set_position
    self.position = html_page.max_region_position(region_category) + 1
  end
  
  def set_name
    self.name = region_category ? "#{region_type}_#{position}" : region_type
  end
    
  def add_panel
    panels.create
  end
  
  def add_panels(region_panels)
    region_panels.each { |panel| panels.create(:width => panel['width'], :max_widgets => panel['max_widgets'], :widget_types => panel['widget_types'], :html_page_id => html_page_id) }
  end
  
  def add_row(columns)
    columns ||= default_rows
    row = html_page.rows.create
    columns.each {|column| row.add_column(column) }
    self.rows << row    
  end
  
  def add_region(region_template)
    region = TEMPLATES['regions'][region_template]
    regions.create(:name => region['name'], :flexible => region['flexible'])
  end
  
  def find_panel(name)
    panels.detect { |panel| panel.name == name } || panels.first
  end
  
  def max_position
    existing_regions = regions.select {|region| !region.position.nil?}
    current_highest = existing_regions.map(&:position).max
    current_highest ||= 0
  end  

  def max_panel_position
    existing_panels = panels.select {|panel| !panel.position.nil?}
    current_highest = existing_panels.map(&:position).max
    current_highest ||= 0
  end  
          
end