class Panel
  include Mongoid::Document
  
  field :span
  
  belongs_to :page
  belongs_to :region
  belongs_to :panel
  has_many :panels
  has_many :widgets
  
  def split(columns)
    array = columns.split('x').map {|i| i.to_i}
    array.delete(0)
    array.each do |column|
      panels.create(:span => column)
    end
  end
  
  def sub_panel?
    panel
  end
  
end