class Event 
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  belongs_to :event_series
  belongs_to :institution
  
  field :title
  field :location
  field :start_time, :type => DateTime
  field :end_time, :type => DateTime
  field :summary
  field :description  
  field :content
  field :all_day
  field :period
  field :frequency
  field :position  
  field :series_id
  field :category
  
  validates_presence_of :start_time
  
  scope :upcoming, where(:start_time.gte => Time.now).asc(:start_time)
  
  #def find_events_by_month(month)
    #events.select {|event| event.start_date.month == month}
  #end  
  
  REPEATS = [
              "Does not repeat",
              "Daily"          ,
              "Weekly"         ,
              "Monthly"        ,
              "Yearly"         ,
              "Monday"         ,
              "Tuesday"        ,
              "Wednesday"      ,
              "Thursday"       ,
              "Friday"         ,
              "Saturday"       ,
              "Sunday"         ,
  ]
  
  CATEGORIES = [
              "All",
              "Service",
              "Coffee Morning",
              "Charity",
              "Fundraising",
              "Speaker",
              "Concert",
              "Meeting",
              "Social"
  ]
    
  def start_date
    start_time.to_date
  end
  
  def end_date
    end_time.to_date
  end
  
  def self.by_month_and_year(month, year)
    Event.all.select {|event| event.start_time.month == month && event.start_time.year == year}
  end
  
end
