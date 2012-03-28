class Column
  include Mongoid::Document
  
  field :span
  
  embedded_in :panel, :inverse_of => :columns
  has_many :widgets
end