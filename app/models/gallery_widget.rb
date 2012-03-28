class GalleryWidget < Widget
  has_and_belongs_to_many :photos
  
  field :display, :default => 'Stacked'
  field :display_caption, :default => false, :type => Boolean
  field :display_in_lightbox, :default => true, :type => Boolean
  field :width, :type => Integer
  
  def image_width
    if display == 'Stacked' && width.nil?
      #{}"#{(column.to_i * 80) - 20}x>"
      "#{(panel.span * 80) - 20}x>"
    else 
      width.nil? ? 'x140' : "x#{width}"
    end
  end

end