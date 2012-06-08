class ArticlesPage < Page
  field :number_to_display, :type => Integer, :default => 5
  field :snippet_size, :type => Integer, :default => 300
  field :group_specific, :type => Boolean, :default => false
  field :template, :default => 'article'
  belongs_to :category
  
  def articles(month)
    articles = category.articles.desc(:date)
    if month 
      articles = articles.select {|a| a.date.strftime('%m-%Y') == month}.first(Integer(number_to_display))
    else
      articles = articles.desc(:date).limit(Integer(number_to_display))
    end
    articles
  end
end