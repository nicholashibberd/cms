class NavMenu
  include Mongoid::Document
  field :name
  field :menu_type
  
  belongs_to :group 
  has_many :nav_items
  
  scope :top_level, where(:group_id => nil)
  
  def order_nav_items(params)
    nav_items.each do |nav_item|
      nav_item.position = params['navitem'].index(nav_item.id.to_s) + 1
      nav_item.save!
    end
  end
  
  def max_position
    existing_nav_items = nav_items.select {|nav_item| !nav_item.position.nil?}
    current_highest = existing_nav_items.map(&:position).max
    current_highest ||= 0
  end  
  
  def self.admin_nav
    top_level.where(:menu_type => 'admin').first
  end

  def self.main_nav
    top_level.where(:menu_type => 'main_nav').first
  end
    
end
