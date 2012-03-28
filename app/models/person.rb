class Person
  include Mongoid::Document
  
  field :name, :type => String
  field :role, :type => String
  field :profile, :type => String
  field :email, :type => String
  field :phone, :type => String
  
  has_many :articles
  belongs_to :group
  
  scope :top_level, where(:group_id => nil)
end
