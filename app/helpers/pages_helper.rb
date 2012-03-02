module PagesHelper
  def render_page_template(page, action)
      case page.page_type
        when 'articles_page' then render "cms/pages/show/articles_page", :article => @article
        when 'calendar_page' then render "cms/pages/show/calendar_page"
        else render "cms/pages/#{action}/content_page"
      end
  end

  def page_columns(page)
    array = page.template.split('x').map {|i| i.to_i}
    array.delete(0)
    array
  end
  
  def image_width(column)
    (column * 80) - 20
  end
  
end