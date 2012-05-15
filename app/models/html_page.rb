class HtmlPage < Page
      
  field :top_header
  field :layout
      
  has_many :panels
  has_many :regions
  
  after_create :setup
  
  def setup
    create_regions(template)
  end
  
  def create_regions(page_template)
    template = TEMPLATES['templates'][page_template]
    if template
      self.update_attributes(:layout => template['layout'])
      template['regions'].each do |region|
        add_region(region['region_type'])
      end
    end
  end  
  
  def add_region(region_type)
    region = TEMPLATES['regions'][region_type]   
    new_region = self.regions.create(:region_type => region['region_type'], :region_category => region['region_category'], :flexible => region['flexible'])
    new_region.add_panels(region['panels']) if region['panels']
  end
  
  def find_region(name)
    regions.detect {|region| region.name == name}
  end
  
  def find_panel(panel_name)
    panels.detect {|panel| panel.name == panel_name}    
  end
  
  def max_region_position(region_type)
    existing_regions = regions.by_type(region_type)
    current_highest = existing_regions.map(&:position).compact.max
    current_highest ||= 0
  end
  
end