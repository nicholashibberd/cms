class ProfileWidget < Widget
  field :content
  field :photo_id
  
  embedded_in :profile_page
  
  def photo
    Photo.find(photo_id)
  end
end