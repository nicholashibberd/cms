class Column
  include Mongoid::Document
  
  field :span
  
  belongs_to :row
  has_many :rows
  has_many :widgets
  
  def add_row
    rows.create
  end
  
end