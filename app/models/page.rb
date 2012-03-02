class Page 
  include Mongoid::Document 
  
  field :name, :type => String
  field :slug, :type => String
  field :title, :type => String
  field :template

  has_many :widgets  
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
  
end