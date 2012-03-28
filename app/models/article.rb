class Article
  include Mongoid::Document
  
  field :title
  field :content
  field :date, :type => Date, :default => Date.today

  belongs_to :person
  belongs_to :group
  embeds_many :comments
  belongs_to :category
  validates_presence_of :date
  
  scope :by_group, lambda {|group_id| where(:group_id => group_id)}
  scope :by_category, lambda {|category_id| where(:category_id => category_id)}
  scope :top_level, where(:group_id => nil)
  
  def add_comment(params)
    comments << Comment.new(params[:comment])
  end
  
  def find_comment(comment_id)
    comments.select {|comment| comment.id.to_s == comment_id}.first
  end
  
  def self.by_category_group_and_month(category, group, month)
    articles = self.all
    articles = articles.by_category(category.id) if category
    articles = articles.by_group(group.id) if group
    articles = articles.select {|a| a.date.strftime('%m-%Y') == month} if month
    articles
  end
  
  def display_categories
    categories.map {|cat| cat.name}.join(', ')
  end
  
  def self.months_with_articles(category, group)
    articles = by_category_group_and_month(category, group, nil)
    dates = articles.map(&:date)
    dates.map {|date| date.to_date.at_beginning_of_month}.uniq    
  end
  
end