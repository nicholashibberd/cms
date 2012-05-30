class Article
  include Mongoid::Document
  default_scope desc(:date)
  
  field :title
  field :content
  field :date, :type => Date, :default => Date.today

  belongs_to :person
  belongs_to :group
  embeds_many :comments
  validates_presence_of :date
  
  scope :by_group, lambda {|group_id| where(:group_id => group_id)}
  scope :top_level, where(:group_id => nil)
  
  def add_comment(params)
    comments << Comment.new(params[:comment])
  end
  
  def find_comment(comment_id)
    comments.select {|comment| comment.id.to_s == comment_id}.first
  end
  
  def self.by_group_and_month(group, month)
    sermons = self.all
    sermons = sermons.by_group(group.id) if group
    sermons = sermons.select {|a| a.date.strftime('%m-%Y') == month} if month
    sermons
  end
  
  def self.months_with_articles(group)
    articles = by_group_and_month(group, nil)
    dates = articles.map(&:date)
    dates.map {|date| date.to_date.at_beginning_of_month}.uniq    
  end
  
end