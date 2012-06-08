class PhotoWidget < Widget
  belongs_to :photo
  
  field :caption
  field :display_in_lightbox, :default => true, :type => Boolean
  field :width, :type => Integer
  field :link
  
  def image_width
    if panel && !panel.width.nil?
      "#{panel.width}x>"
    else 
      width.nil? ? '140x>' : "#{width}x>"
    end
  end

end