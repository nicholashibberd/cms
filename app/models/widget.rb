class Widget
  include Mongoid::Document
  field :position, :type => Integer, :default => 1000
  field :css_id
  field :column, :default => '1'
  belongs_to :page
  
  referenced_in :page, :inverse_of => :widgets
  
  scope :order_by_position, order_by(:position => :asc)
  scope :by_column, lambda {|column| where(:column => column)}
      
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
