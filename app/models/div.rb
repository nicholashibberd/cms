class Div
  include Mongoid::Document
  
  field :css_class
  field :css_id
  field :position
    
  belongs_to :html_page
  belongs_to :div
  has_many :divs
  has_many :widgets
  
end