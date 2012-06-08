module Cms
  module WidgetsHelper
    def path_for_widget(page, widget)
      widget.new_record? ? page_widgets_path(@group, page) : page_widget_path(@group, page, widget)
    end
    
  end
end