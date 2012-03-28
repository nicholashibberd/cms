class ContentPage < Page
    
  after_create :create_regions
  
  def create_regions
    case template
      when 'template2' then regions.create(:name => 'Main', :span => 7); regions.create(:name => 'Sidebar', :span => 5)
      else regions.create(:name => 'Main', :span => 12)
    end
  end
    
end