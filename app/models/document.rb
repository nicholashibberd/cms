class Document
  include Mongoid::Document
  #include Mongoid::Paperclip  

  field :document
  field :title
  
  belongs_to :group
  
  #has_mongoid_attached_file :pdf
  scope :top_level, where(:group_id => nil)  
  
end