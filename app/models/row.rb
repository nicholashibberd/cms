class Row
  include Mongoid::Document
  default_scope asc(:position)
  
  field :header, :type => String
  field :position, :type => Integer
  
  belongs_to :page
  belongs_to :region
  has_many :columns
  belongs_to :column
  
  before_create :update_position
  
  def add_column(span)
    columns.create(:span => span)
  end
  
  def update_position
    self.position = page.rows.count + 1
  end
  
  
end