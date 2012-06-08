class GalleryWidget < Widget
  has_and_belongs_to_many :photos
  
  field :display, :default => 'Stacked'
  field :display_caption, :default => false, :type => Boolean
  field :display_in_lightbox, :default => true, :type => Boolean
  field :width, :type => Integer
  
  def image_width
    if display == 'Stacked' && width.nil? && column
      "#{(column.span * 80) - 20}x>"
    elsif panel && !panel.width.nil?
      "#{panel.width}x>"
    else 
      width.nil? ? '140x>' : "#{width}x>"
    end
  end

end