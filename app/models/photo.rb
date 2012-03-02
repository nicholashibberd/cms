class Photo 
  include Mongoid::Document

  field :cover_image_uid
  field :caption
  field :link
  
  image_accessor :cover_image
end
