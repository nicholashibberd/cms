class Row
  include Mongoid::Document
  
  belongs_to :page
  has_many :columns
  belongs_to :column
  
  def add_column(span)
    columns.create(:span => span)
  end
end