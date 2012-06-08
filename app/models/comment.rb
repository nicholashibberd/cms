class Comment
  include Mongoid::Document
  field :content, :type => String
  field :author
  
  embedded_in :articles, :inverse_of => :comments
end