class Panel
  include Mongoid::Document
  
  field :width, :type => Integer
  field :max_widgets, :type => Integer
  field :widget_types, :type => Array
  field :position
  field :name
  field :panel_category
    
  belongs_to :html_page
  belongs_to :region
  has_many :widgets
  
  before_create :set_position, :set_name, :set_panel_category
  
  def set_position
    self.position = region.max_panel_position + 1
  end  
  
  def set_name
    self.name = "#{region.name}_panel_#{position}"
  end
  
  def set_panel_category
    self.panel_category = "#{region.region_type}_panel_#{position}"
  end
  
  def split(columns)
    array = columns.split('x').map {|i| i.to_i}
    array.delete(0)
    array.each do |column|
      panels.create(:span => column)
    end
  end
  
  def sub_panel?
    panel
  end
  
  def full?
    widgets.count >= max_widgets && max_widgets != -1
  end
  
end