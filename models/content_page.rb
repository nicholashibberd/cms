class ContentPage < Page
    
  after_create :setup
  
  def setup
    create_rows(template)
  end
  
  def create_rows(page_template)
    template = Site::TEMPLATES.detect {|site_template| site_template[:name] == page_template}
    row = template[:first_row] || [12]
    add_row(row)
  end
  
  def add_row(columns)
    row = rows.create
    columns.each {|column| row.add_column(column) }
  end
  
  def homepage
    row = rows.create
    column1 = row.add_column(8)

    column1_row1 = column1.add_row
    column1_row1.add_column(8)
    
    column1_row2 = column1.add_row
    column1_row2.add_column(4)
    column1_row2.add_column(4)
    
    column1_row3 = column1.add_row
    column1_row3.add_column(4)
    column1_row3.add_column(4)
    
    column2 = row.add_column(4)    
  end
  
  def profile(number_of_times)
    number_of_times.times do
      row = rows.create
      row.add_column(2)
      row.add_column(10)
    end
  end
    
end