module PagesHelper
  def render_page_template(page, action)
    send("render_#{page.page_type}_template", page, action)
  end
  
  def render_articles_page_template(page, action)
    render "cms/pages/show/articles_page", :article => @article
  end

  def render_calendar_page_template(page, action)
    render "cms/pages/show/calendar_page"
  end

  def render_html_page_template(page, action)
    render "cms/pages/#{action}/html_page"
  end

  def render_content_page_template(page, action)
    render "cms/pages/#{action}/content_page"
  end

  def page_columns(page)
    array = page.template.split('x').map {|i| i.to_i}
    array.delete(0)
    array
  end

  def panel_columns(panel_columns)
    panel_columns.split('x').map {|i| i.to_i}
  end
  
  def background_image(page)
    if !page.photos.empty?
      content_tag(:div, (image_tag page.photos.first.cover_image.url), :id => "background_image")
    else
      return
    end
  end
  
  def background_layout
    @page.nil? || @page.photos.empty? ? 'no_background' : 'background'
  end

end