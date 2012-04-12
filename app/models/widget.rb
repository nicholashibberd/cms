class Widget
  include Mongoid::Document
  field :position, :type => Integer, :default => 1000
  field :css_id
  field :panel_id
  
  belongs_to :page
  belongs_to :column
  
  scope :order_by_position, order_by(:position => :asc)
  scope :by_panel, lambda {|panel_id| where(:panel_id => panel_id)}
  scope :by_region, lambda {|region| where(:region => region)}
      
  def widget_type
    self._type.underscore
  end

  def self.order_widgets(widgets)
    widgets.each do |column, widget_ids|
      widget_ids.each_with_index do |widget_id, index|
        widget = self.find(widget_id)
        widget.update_attributes(:column => column, :position => index + 1)
      end
    end
  end
  
end
