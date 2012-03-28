module Cms
  module NavMenusHelper
  
    def main_navigation(group)
      if group && group.nav_menus.first
        group.nav_menus.first
      else
        NavMenu.first
      end
    end
        
  end
end