module NavHelper
  def nav_link(nav_item)
    link_target = nav_item.page ? host_page_path(nav_item.page) : nav_item.link_target
    if nav_item.page == @page
      link_to nav_item.name, link_target, :class => 'selected'
    else
      link_to nav_item.name, link_target
    end
  end
  
  def admin_nav_link(nav_item)
    if nav_item.link_target == request.path
      link_to nav_item.name, nav_item.link_target, :class => 'selected'
    else
      link_to nav_item.name, nav_item.link_target
    end
  end
  
end